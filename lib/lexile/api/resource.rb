module Lexile
  module Api
    class Resource
      class << self
        #api_model
        #
        # It tells the parser which Lexile::Model to use when parsing JSON and creating objects
        #
        # @param klass [Lexile::Model] The Lexile::Model class to be used when parsing and objectifying responses.
        def api_model(klass)
          class_eval <<-END
                  def api_model
          #{klass}
                  end
          END
        end
      end

      # initialize
      # @param client [Lexile::API::Client] required to issue HTTP calls
      def initialize( client )
        @client = client
      end

      protected
      def to_json_array( param )
        if param.is_a? Array
          return param.to_json
        else
          return [param].to_json
        end
      end

      def to_comma_separated_list( param )
        if param.is_a? Array
          return param.join(',')
        else
          return param
        end
      end
    end
  end
end
