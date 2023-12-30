# frozen_string_literal: true

module ColumnApi
  class Client
    BASE_URL = "https://api.column.com/"

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.request :authorization, :basic, "", api_key
        conn.request :json

        conn.response :parse_dates
        conn.response :json, content_type: "application/json"
      end
    end
  end
end
