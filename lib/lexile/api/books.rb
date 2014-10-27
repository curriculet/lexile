module Lexile
  module Api
    class Books < Resource
      api_model Lexile::Book

      def show id
        response = @client.get( "#{ api_model.api_path }/#{id}" )
        api_model.parse(response.body)
      end

      def find( query_params )
        response = @client.get( "#{ api_model.api_path }", query_params )
        api_model.parse(response.body)
      end

      def find_by_isbn13 isbn13
        self.find( {"ISBN13" => isbn13 })
      end

      def find_by_title title
        self.find( {"title__contains" => title } )
      end

    end
  end
end
