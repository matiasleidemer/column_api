# frozen_string_literal: true

module ColumnApi
  class AchTransferResource < Resource
    def list(params = {})
      response = get_request("transfers/ach", params: params).body
      Collection.from_response(response, key: "transfers", type: AchTransfer)
    end

    def retrieve(ach_transfer_id:)
      AchTransfer.new get_request("transfers/ach/#{ach_transfer_id}").body
    end

    def create(params)
      AchTransfer.new post_request("transfers/ach", body: params).body
    end

    def cancel(ach_transfer_id:)
      AchTransfer.new post_request("transfers/ach/#{ach_transfer_id}/cancel").body
    end

    def reverse(ach_transfer_id:, reason:, description: "")
      AchTransfer.new(
        post_request("transfers/ach/#{ach_transfer_id}/reverse",
                     body: { reason: reason, description: description }).body
      )
    end
  end
end
