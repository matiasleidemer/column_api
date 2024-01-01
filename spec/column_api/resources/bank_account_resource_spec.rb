# frozen_string_literal: true

RSpec.describe ColumnApi::BankAccountResource do
  let(:client) { ColumnApi::Client.new(api_key: "fake") }
  let(:bank_account_id) { "bacc_2YHAXVyuS2xcJW12Buh9zsxV7vC" }

  it "retrieves a Bank Account" do
    stub_get("bank-accounts/#{bank_account_id}", fixture: "bank_accounts/retrieve")

    client.bank_accounts.retrieve(bank_account_id: bank_account_id).tap do |bacc|
      expect(bacc).to be_a(ColumnApi::BankAccount)
      expect(bacc.id).to eql(bank_account_id)
      expect(bacc.created_at).to be_a(Time)
    end
  end

  it "lists Bank Accounts" do
    stub_get("bank-accounts", query: { limit: 2 }, fixture: "bank_accounts/list")

    client.bank_accounts.list(limit: 2).tap do |result|
      expect(result).to be_a(ColumnApi::Collection)
      expect(result.data).to all be_a(ColumnApi::BankAccount)
      expect(result.data.size).to eql(1)
      expect(result.has_more).to be false
    end
  end

  it "creates a Bank Account" do
    body = { description: "Travel Checking", entity_id: "<entity_id>" }

    stub_post("bank-accounts", body: body, fixture: "bank_accounts/retrieve")

    client.bank_accounts.create(body).tap do |bacc|
      expect(bacc).to be_a(ColumnApi::BankAccount)
      expect(bacc.id).to eql("bacc_2YHAXVyuS2xcJW12Buh9zsxV7vC")
    end
  end
end
