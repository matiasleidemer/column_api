# frozen_string_literal: true

RSpec.describe ColumnApi::AchTransferResource do
  let(:client) { ColumnApi::Client.new(api_key: "fake") }
  let(:ach_transfer_id) { "acht_28LtyrWQ7d5CZTXOjKEwVJrnlTa" }

  it "lists ACH Transfers" do
    stub_get("transfers/ach", query: { limit: 2 }, fixture: "ach_transfers/list")

    client.ach_transfers.list(limit: 2).tap do |result|
      expect(result).to be_a(ColumnApi::Collection)
      expect(result.data).to all be_a(ColumnApi::AchTransfer)
      expect(result.data.size).to eql(2)
      expect(result.has_more).to be false
    end
  end

  it "retrieves an ACH Transfer" do
    stub_get("transfers/ach/#{ach_transfer_id}", fixture: "ach_transfers/retrieve")

    client.ach_transfers.retrieve(ach_transfer_id: ach_transfer_id).tap do |bacc|
      expect(bacc).to be_a(ColumnApi::AchTransfer)
      expect(bacc.id).to eql(ach_transfer_id)
      expect(bacc.type).to eql("DEBIT")
    end
  end

  it "creates an ACH Transfer" do
    body = { amount: 100_000, currency_code: "USD" }

    stub_post("transfers/ach", body: body, fixture: "ach_transfers/create")

    client.ach_transfers.create(body).tap do |bacc|
      expect(bacc).to be_a(ColumnApi::AchTransfer)
      expect(bacc.amount).to eql(100_000)
    end
  end

  it "cancels an ACH Transfer" do
    stub_post("transfers/ach/#{ach_transfer_id}/cancel", fixture: "ach_transfers/cancel")

    client.ach_transfers.cancel(ach_transfer_id: ach_transfer_id).tap do |bacc|
      expect(bacc).to be_a(ColumnApi::AchTransfer)
      expect(bacc.status).to eql("CANCELED")
    end
  end

  it "reverts an ACH Transfer" do
    body = { reason: "incorrect_amount", description: "My bad" }

    stub_post("transfers/ach/#{ach_transfer_id}/reverse", body: body, fixture: "ach_transfers/reverse")

    client.ach_transfers.reverse(
      ach_transfer_id: ach_transfer_id,
      reason: "incorrect_amount",
      description: "My bad"
    ).tap do |bacc|
      expect(bacc).to be_a(ColumnApi::AchTransfer)
      expect(bacc.amount).to eql(12_500)
    end
  end
end
