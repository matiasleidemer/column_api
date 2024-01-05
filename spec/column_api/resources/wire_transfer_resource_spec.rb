# frozen_string_literal: true

RSpec.describe ColumnApi::WireTransferResource do
  let(:client) { ColumnApi::Client.new(api_key: "fake") }
  let(:wire_transfer_id) { "wire_2DucXfsrbVzW4GsNMUmFum1eOeP" }

  it "lists Wire Transfers" do
    stub_get("transfers/wire", query: { limit: 1 }, fixture: "wire_transfers/list")

    client.wire_transfers.list(limit: 1).tap do |result|
      expect(result).to be_a(ColumnApi::Collection)
      expect(result.data).to all be_a(ColumnApi::WireTransfer)
      expect(result.data.size).to eql(1)
      expect(result.has_more).to be true
    end
  end

  it "retrieves a Wire Transfer" do
    stub_get("transfers/wire/#{wire_transfer_id}", fixture: "wire_transfers/retrieve")

    client.wire_transfers.retrieve(wire_transfer_id: wire_transfer_id).tap do |wire|
      expect(wire).to be_a(ColumnApi::WireTransfer)
      expect(wire.id).to eql(wire_transfer_id)
      expect(wire.status).to eql("NONE")
    end
  end

  it "creates a Wire Transfer" do
    body = { amount: 2000, currency_code: "USD" }

    stub_post("transfers/wire", body: body, fixture: "wire_transfers/retrieve")

    client.wire_transfers.create(body).tap do |wire|
      expect(wire).to be_a(ColumnApi::WireTransfer)
      expect(wire.id).to eql(wire_transfer_id)
    end
  end

  it "reverses a Wire Transfer" do
    body = { reason: "beneficiary_request", description: "Some description" }

    stub_post("transfers/wire/#{wire_transfer_id}/reverse", body: body, fixture: "wire_transfers/retrieve")

    client.wire_transfers.reverse(
      wire_transfer_id: wire_transfer_id,
      reason: "beneficiary_request",
      description: "Some description"
    ).tap do |wire|
      expect(wire).to be_a(ColumnApi::WireTransfer)
      expect(wire.id).to eql(wire_transfer_id)
    end
  end
end
