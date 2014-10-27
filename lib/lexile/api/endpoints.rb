module Lexile
  module Api
    module Endpoints


      # books
      #
      # @example
      #   Lexile.books.find(title: or isbn:  ) returns the details of book
      #
      # @return [Lexile::Api::Books] A properly initialized books api client ready for calls


      def books
        @books ||= Lexile::Api::Books.new( client )
      end

    end
  end
end
