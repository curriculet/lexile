module Lexile
  module Api
    # Represents a list of results for a paged request.
    class ResultsList
      include Enumerable

      # Create a results list from a PageList
      # @api private
      # @return [ResultsList]
      def initialize( page_list )
        @pages = page_list
      end

      # Iterate over results list
      # @api public
      # @return [nil]
      # @example
      #   results = Lexile::Book.find # returns a ResultsList
      #   results.each do |book|
      #     puts district.title
      #   end
      def each
        @pages.each do |page|
          page.each do |elem|
            yield elem
          end
        end
      end
    end
  end
end