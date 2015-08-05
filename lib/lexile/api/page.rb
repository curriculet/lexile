module Lexile
  module Api
    # Represents a page of data
    class Page
      include Enumerable

      # Request a page of data and store the results in this instance
      # @api private
      # @return [Lexile::Api::Page]
      # @example
      #   page = Page.new '/v2.1/book'
      def initialize(client, api_model, uri, query_params = {})
        @client          = client
        @api_model       = api_model
        @uri             = uri
        @query_params    = query_params

        response_json = @client.get( uri, @query_params )
        @all = api_model.parse(response_json)

        raise Lexile::CannotProcessResponse.new('[:meta] is not present in response') unless response_json.has_key?('meta')

        @limit        = response_json['meta']['limit']
        @next         = response_json['meta']['next']
        #puts "NEXT URI IS ==>#{@next}<=="
        @offset       = response_json['meta']['offset']
        @previous     = response_json['meta']['previous']
        @total_count  = response_json['meta']['total_count']
      end

      # Gets next page if one is present, nil otherwise
      # @api private
      # @return [Lexile::Api::Page, nil] Next page, or nil if last
      # @example
      #   next_page = page.next
      #   unless next_page.nil?
      #     next_page.each do |elem| puts elem; end
      def next
        return nil if @next.nil?
        Page.new( @client, @api_model, @next, {}  )
      end

      # Iterate over all elements in the page
      # @api private
      # @return [Array] List of all elements
      # @example
      #   page.each { |elem| puts elem }
      def each(&blk)
        @all.each(&blk)
      end

      # Get all elements in page
      # @api private
      # @return [Array] List of all elements
      # @example
      #   all_elems = page.all
      attr_reader :all

      # Retrieve the last element or n elements in the resource
      # @api public
      # @param num [nil, Integer] If nil, last elem; else, num elems to fetch
      # @return [Lexile::Model, Lexile::Api::Page] elem, or
      #   elems found. If list, sorted in ascending order of ids.
      # @example
      #   books = Lexile.books.first(20)
      #   last_elem = books.last
      #   last_elems = books.last 5
      def last(num = nil)
        return @all.last num if num
        @all.last
      end
    end
  end
end