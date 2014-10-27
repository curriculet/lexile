require 'hashie/rash'

module Lexile
  module API
    class Client
      include HTTParty

      # initialize
      #
      # The Lexile Api Client can be configured via Lexile.configure block
      # or via a hash with the appropriate values set
      #
      # endpoint:     required. The API endpoing i.e https://api.lexile.com
      # api_version:  required. The API version (v1 or V1.1)
      # username:     required. Your lexile username
      # password:     required. Your lexile password
      # timeout:      optional. The HTTP timeout
      # testing:      optional. Set it to true to activate debugging output
      #
      # @param configuration [Lexile Hash] A hash or Lexile::Configuration that contains the parameters to
      #     be used when issuing HTTP Calls
      def initialize( configuration )

        if configuration.is_a?(Module) && configuration.to_s == 'Lexile'
          config = configuration
        elsif configuration.is_a?(Hash)
          config = Hashie::Rash.new( configuration )
          config.api_url = [config.endpoint,config.api_version].join('/')
        end

        #if config.api_key
          #self.class.default_params({ 'api_key' => config.api_key})
        #else
          #raise Lexile::InvalidCredentials.new("Api Key is not present but it is required.")
        #end

        self.class.base_uri( config.api_url )                     if config.api_url
        self.class.default_timeout config.timeout.to_f            if config.timeout
        self.class.debug_output                                   if config.testing
        self.class.headers({'User-Agent' => config.user_agent})   if config.user_agent
      end

      # get
      # send an HTTPS Get request against Edelement's API.
      # Yields the get_options before sending making the request.
      #
      #
      # @param path    [String] The path for the api endpoint (with leading slash)
      # @param params  [Hash]   A hash of query arguments for the request (optional)
      # @param headers [Hash]   A hash of header fields (optional).
      #
      #
      # @return [String]. The raw response body (JSON is expected) Raises appropriate exception if it fails
      # @raise Lexile::HTTPError when any HTTP error response is received
      def get( path, params={}, headers={})
        get_options = build_get_options( params, headers)
        yield get_options if block_given?

        #puts "CALLING API: #{Lexile.api_url}#{path} ===#{get_options}"
        response = self.class.get( path, get_options)

        case response.code
        when 200..201
          response
        when 400
          raise Lexile::BadRequest.new(response, params)
        when 401
          raise Lexile::AuthenticationFailed.new(response, params)
        when 404
          raise Lexile::NotFound.new(response, params)
        when 500
          raise Lexile::ServerError.new(response, params)
        when 502
          raise Lexile::Unavailable.new(response, params)
        when 503, 504
          raise Lexile::RateLimited.new(response, params)
        else
          raise Lexile::UnknownStatusCode.new(response, params)
        end
      end

      # build_get_options
      # Build the hash of options for an HTTP get request.
      #
      # @param params  [Hash] optional. Any query parameters to add to the request.
      # @param user_headers [Hash] optional. Any query parameters to add to the request.
      #
      # @return [Hash] The properly formated get_options.
      def build_get_options( params={}, user_headers={})
        get_options = {}
        query ={ format: 'json'} #all requests get this query params

        query.merge!(params)

        # pass any headers
        headers ={}
        headers.merge!( user_headers )

        get_options[:query]      = query
        get_options[:headers]    = headers
        get_options[:basic_auth] = { username: Lexile.options[:username],
                                     password: Lexile.options[:password]}
        get_options
      end
    end
  end
end
