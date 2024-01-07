# frozen_string_literal: true

module ColumnApi
  class AchReturnResource < Resource
    def list(params = {})
      response = get_request("transfers/ach/returns", params: params).body
      Collection.from_response(response, key: "ach_returns", type: AchReturn)
    end

    def retrieve(ach_transfer_id:)
      AchReturn.new get_request("transfers/ach/#{ach_transfer_id}/return").body
    end

    def create(ach_transfer_id:, params: {})
      AchReturn.new post_request("transfers/ach/#{ach_transfer_id}/return", body: params).body
    end
  end
end
