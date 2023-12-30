# frozen_string_literal: true

module ColumnApi
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise BadRequestError, response.body["message"]
      end

      response
    end
  end
end
