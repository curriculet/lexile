module Lexile
  class Error < ::StandardError; end
  class InvalidCredentials < Error; end
  class CannotProcessResponse < Error; end

  class HTTPError < Error
    attr_reader :response
    attr_reader :params

    def initialize(response, params = {})
      @response = response
      @params = params
      super(response)
    end

    def composed_message
      "#{self.class.to_s} request_params: #{@params} response_status_code: #{@response.code} response_headers:#{@response.headers}"
    end

    def to_s
      composed_message
    end
  end

  class NotFound              < HTTPError; end
  class Unavailable           < HTTPError; end
  class BadRequest            < HTTPError; end
  class ServerError           < HTTPError; end
  class AuthenticationFailed  < HTTPError; end
  class TooManyRequests       < HTTPError; end
  class UnknownStatusCode     < HTTPError; end
end
