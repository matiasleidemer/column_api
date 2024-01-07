# frozen_string_literal: true

RSpec.describe ColumnApi::AchReturnResource do
  let(:client) { ColumnApi::Client.new(api_key: "fake") }
  let(:ach_transfer_id) { "acht_28LtyrWQ7d5CZTXOjKEwVJrnlTa" }

  it "lists ACH Returns" do
    stub_get("transfers/ach/returns", query: { limit: 1 }, fixture: "ach_returns/list")

    client.ach_returns.list(limit: 1).tap do |result|
      expect(result).to be_a(ColumnApi::Collection)
      expect(result.data).to all be_a(ColumnApi::AchReturn)
      expect(result.data.size).to eql(1)
      expect(result.has_more).to be true
    end
  end

  it "retrieves an ACH Return" do
    stub_get("transfers/ach/#{ach_transfer_id}/return", fixture: "ach_returns/retrieve")

    client.ach_returns.retrieve(ach_transfer_id: ach_transfer_id).tap do |achr|
      expect(achr).to be_a(ColumnApi::AchReturn)
      expect(achr.ach_transfer_id).to eql(ach_transfer_id)
    end
  end

  it "creates an ACH Return" do
    params = { return_code: "R10" }

    stub_post("transfers/ach/#{ach_transfer_id}/return", body: params, fixture: "ach_returns/retrieve")

    client.ach_returns.create(ach_transfer_id: ach_transfer_id, params: params).tap do |achr|
      expect(achr).to be_a(ColumnApi::AchReturn)
      expect(achr.details.first.return_code).to eql("R10")
    end
  end
end
