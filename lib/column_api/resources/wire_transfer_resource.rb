# frozen_string_literal: true

module ColumnApi
  class WireTransferResource < Resource
    def list(params = {})
      response = get_request("transfers/wire", params: params).body
      Collection.from_response(response, key: "transfers", type: WireTransfer)
    end

    def retrieve(wire_transfer_id:)
      WireTransfer.new get_request("transfers/wire/#{wire_transfer_id}").body
    end

    def create(params)
      WireTransfer.new post_request("transfers/wire", body: params).body
    end

    def reverse(wire_transfer_id:, reason:, description: "")
      WireTransfer.new(
        post_request(
          "transfers/wire/#{wire_transfer_id}/reverse",
          body: { reason: reason, description: description }
        ).body
      )
    end
  end
end
