module Lexile
  class InvalidCredentials < StandardError; end
  class CannotProcessResponse < StandardError; end

  class HTTPError < StandardError
    attr_reader :response
    attr_reader :params

    def initialize(response, params = {})
      @response = response
      @params = params
      super(response)
    end

    def to_s
      "#{self.class.to_s} : #{response.code} #{response.body}"
    end
  end

  class NotFound              < HTTPError; end
  class Unavailable           < HTTPError; end
  class BadRequest            < HTTPError; end
  class ServerError           < HTTPError; end
  class AuthenticationFailed  < HTTPError; end
  class UnknownStatusCode     < HTTPError; end
end
