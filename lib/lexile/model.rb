module Lexile
  module Model
    def self.included(base)
      base.send :include, InstanceMethods
      base.send :extend, ClassMethods
    end

    module InstanceMethods
      def to_json(*args)
        as_json(*args).to_json(*args)
      end

      def as_json(args = {})
        self.to_hash.stringify_keys
      end

      def to_i; id; end

      def ==(other)
        id == other.id
      end

      def json_root
        self.class.json_root
      end
    end

    module ClassMethods
      # api_path
      # This sets the API path so the API collections can use them in an agnostic way
      # @param path [String] the api path for the current model with a leading slash
      # @return [void]
      def api_path(path = nil)
        @_api_path ||= path
      end

      # Understanding the Response
      # The API will return a JSON response for each query.  Lets take a look at a sample response.
      #
      #       {"meta":
      #                 {"limit": 20, "next": null, "offset": 0, "previous": null, "total_count": 1},
      #       "objects":
      #           [
      #               {
      #                   "ISBN": "1234567890",
      #                   "ISBN13": "9781234567890",
      #                   "author": "Author, Fake",
      #                   "booktype": "Fiction",
      #                   "call_number": "",
      #                   "categories":
      #                       [{"id": 1, "name": "Action", "resource_uri": "/api/fab/2013-02-04/category/1/"}],
      #                   "categories_display": "",
      #                   "copyright": "2013",
      #                   "id": 1,
      #                   "keyword": "",
      #                   "language": "",
      #                   "lexile": 1000,
      #                   "lexile_code": "",
      #                   "lexile_code_spanish": "",
      #                   "lexile_display": "1000L",
      #                   "lexile_spanish": null,
      #                   "max_age": null,
      #                   "min_age": null,
      #                   "pages": 5,
      #                   "publisher":
      #                   "Fake Publisher",
      #                   "resource_uri": "/api/fab/2013-02-04/book/1/",
      #                   "serial": 1,
      #                   "series": "",
      #                   "summary": "This is a sample summary",
      #                   "timestamp": "2013-05-04T17:43:50",
      #                   "title": "Test Book",
      #                   "word_count": 400,
      #                   "word_count_spanish": null
      #               }
      #           ]
      #       }
      #
      # We will mainly cover the meta data in the response in this section.  For more details about the book object
      # itself please refer to the resources documentation. Lets take a look at just the meta block.
      #
      #      {"meta":{"limit": 20, "next": null, "offset": 0, "previous": null, "total_count": 1}
      #
      # In the meta object you will find key pieces of information about your result.
      # limit: By default only 20 objects are sent back in each response.  You can increase or decrease this limit by
      # supplying a limit filter on your query.
      #
      # next:  The url for you to fetch the next set of results in your query.  This url will not be a fully qualified
      # url but instead relative to the base url we discussed earlier.  If the value is none there is not another set
      # of results and you have reached the last "page"
      #
      # offset: The number of records you are offsetting this result by.  For example if you had a limit of 20 and
      # there were 100 total records.  If you had an offset of 60 that would mean you are looking at records 61-80.
      #
      # previous: Same as next but refers to the previous set of results. If this is null there are no previous sets
      # available.
      #
      # total_count:  The total number of results in the query.  For example if you had a query that generated 100
      # results this number would be 100.
      #
      # A field that is not explained in the resources documentation that should be noted here is resource_uri.
      # You will notice in our sample response there is a resource_uri for the category and the book.  This is the
      # url you will use to obtain information about that particular object.  Like the next and previous urls, this is
      # not fully qualified and is relative to the base url discussed earlier.

      # Parses a request.body response into a Lexile::Model objects
      #
      def parse( raw_json )
        parsed_json = String === raw_json ? JSON.parse(raw_json) : json
        if parsed_json.has_key?('objects')
          #this is a multi record and data should contain an array
          unless parsed_json['objects'].is_a? Array
            raise Lexile::CannotProcessResponse.new('[:objects] is present in response but it does not contain an Array')
          end
          return parsed_json['objects'].map {|array_element|  new( array_element )  }
        else
          return  new( parsed_json )
        end
      end

    end

  end
end
