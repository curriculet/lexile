module Lexile
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :api_version, :user_agent, :testing, :timeout].freeze
    VALID_OPTIONS_KEYS    = [:username,:password].freeze

    #@!visibility private
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT      = 'https://fabapi.lexile.com'
    DEFAULT_API_VERSION   = '/api/fab/v2.1'
    DEFAULT_USER_AGENT    = 'Lexile API Ruby Gem by Curriculet'.freeze
    DEFAULT_TIMEOUT       = nil
    DEFAULT_TESTING       = false
    DEFAULT_USERNAME      = nil
    DEFAULT_PASSWORD      = nil

    # Build accessor methods for every config options so we can do this, for example:
    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset!
    end

    # reset!
    # set all options to their defaults and free the client
    def reset!
      self.endpoint     = DEFAULT_ENDPOINT
      self.api_version  = DEFAULT_API_VERSION
      self.user_agent   = DEFAULT_USER_AGENT
      self.timeout      = DEFAULT_TIMEOUT
      self.testing      = DEFAULT_TESTING
      self.username     = DEFAULT_USERNAME
      self.password     = DEFAULT_PASSWORD

      @client           = nil
    end

    #@return [Hash] of all options
    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end

    # api_url
    # Interpolate the base url for all calls
    # return [String] the base url for all api calls
    def api_url( path = nil)
      [endpoint,path].compact.join('/')
    end

    def config
      self
    end

    # Yields itself for use in the configuration block
    # @example
    #  Lexile.configure do |c|
    #    c.api_key    = <MY-API-KEY>
    #    c.api_verion = '/api/fab/v2'
    #    c.endpoint   = 'https://fabapi.lexile.com'
    #    c.timeout    = '10' #seconds
    #    c.testing    = true
    #  end
    #
    # @return Lexile::API::Client
    #
    def configure
      yield self
      @client = Lexile::API::Client.new( self )
    end

    protected
    def client
      @client ||= Lexile::API::Client.new( self )
    end
  end # Configuration
end
