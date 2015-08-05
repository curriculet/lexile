module Lexile
  module Api
    class Books < Resource
      api_model Lexile::Book

      def show id
        response_json = @client.get( "#{Lexile.api_version}/#{ api_model.api_path }/#{id}" )
        api_model.parse( response_json )
      end

      def find( query_params )
        Lexile::Api::PageList.new( @client, api_model,  query_params ).to_results_list
        #response_json = @client.get( "#{ api_model.api_path }", query_params )
        #api_model.parse( response_json )
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
