module Lexile
  module Api
    # Handles paginated requests.
    class PageList
      include Enumerable

      # Create a new PageList, without making any requests immediately
      # @api private
      # @return [PageList]
      def initialize(client, api_model, query_params = {})
        @client       = client
        @api_model    = api_model
        @uri          = "#{Lexile.api_version}/#{api_model.api_path}"
        @query_params = query_params
      end

      # Iterate through each page, making requests as you iterate
      # @api private
      # @return [nil]
      # @example
      #   pagelist.each do |page|
      #     page.each do |elem|
      #       puts elem
      #     end
      #   end
      def each
        page = Page.new( @client, @api_model, @uri, @query_params )
        until page.nil?
          yield page
          page = page.next
        end
      end

      # Convert PageList into a ResultsList for easier iteration
      # @api private
      # @return [Lexile::Api::ResultsList]
      # @example
      #   pagelist.to_results_list.each { |elem| puts elem }
      def to_results_list
        Lexile::Api::ResultsList.new( self )
      end
    end
  end
end