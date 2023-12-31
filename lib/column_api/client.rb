# frozen_string_literal: true

module ColumnApi
  class Client
    attr_reader :api_key, :base_url, :adapter

    def initialize(api_key:, base_url: BASE_URL, adapter: Faraday.default_adapter)
      @api_key = api_key
      @base_url = base_url
      @adapter = adapter
    end

    def ach_transfers
      AchTransferResource.new(self)
    end

    def ach_returns
      AchReturnResource.new(self)
    end

    def account_numbers
      AccountNumberResource.new(self)
    end

    def bank_accounts
      BankAccountResource.new(self)
    end

    def entities
      EntityResource.new(self)
    end

    def wire_transfers
      WireTransferResource.new(self)
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
