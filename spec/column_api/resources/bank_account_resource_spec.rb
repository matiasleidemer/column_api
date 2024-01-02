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

  it "updates a Bank Account" do
    body = { description: "Travel Checking UPDATE" }

    stub_patch("bank-accounts/#{bank_account_id}", body: body, fixture: "bank_accounts/retrieve")

    client.bank_accounts.update(bank_account_id: bank_account_id, params: body).tap do |bacc|
      expect(bacc).to be_a(ColumnApi::BankAccount)
      expect(bacc.routing_number).to eql("121145307")
    end
  end

  it "deletes a Bank Account" do
    stub_delete("bank-accounts/#{bank_account_id}", fixture: "bank_accounts/delete")

    expect(client.bank_accounts.delete(bank_account_id: bank_account_id)).to be true
  end

  it "retrives the Bank Account history" do
    query = { from_date: "2023-12-15", to_date: "2024-01-02" }

    stub_get("bank-accounts/#{bank_account_id}/history", query: query, fixture: "bank_accounts/history")

    client.bank_accounts.history(
      bank_account_id: bank_account_id,
      from_date: Time.new(2023, 12, 15),
      to_date: Time.new(2024, 1, 2)
    ).tap do |bacc|
      expect(bacc).to be_a(ColumnApi::BankAccount)
      expect(bacc.history).to be_a(Array)
      expect(bacc.history.first.available_balance_credit).to eql("100")
    end
  end
end
