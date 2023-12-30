# frozen_string_literal: true

module ColumnApi
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    private

    def get_request(url, params: {}, headers: {})
      client.connection.get(url, params, headers)
    end
  end
end
