# frozen_string_literal: true

RSpec.describe ColumnApi::AccountNumberResource do
  let(:client) { ColumnApi::Client.new(api_key: "fake") }
  let(:account_number_id) { "acno_25nacNsLD8qLI1Vc6x67sxFU27c" }
  let(:bank_account_id) { "bacc_25nVQr05nZybpyEzw8j0wV6VRUh" }

  it "lists Account numbers from a Bank Account" do
    stub_get("bank-accounts/#{bank_account_id}/account-numbers", query: { limit: 1 }, fixture: "account_numbers/list")

    client.account_numbers.list(bank_account_id: bank_account_id, params: { limit: 1 }).tap do |result|
      expect(result).to be_a(ColumnApi::Collection)
      expect(result.data).to all be_a(ColumnApi::AccountNumber)
      expect(result.data.size).to eql(1)
      expect(result.has_more).to be true
    end
  end

  it "retrieves an Account number" do
    stub_get("account-numbers/#{account_number_id}", fixture: "account_numbers/retrieve")

    client.account_numbers.retrieve(account_number_id: account_number_id).tap do |accn|
      expect(accn).to be_a(ColumnApi::AccountNumber)
      expect(accn.id).to eql(account_number_id)
      expect(accn.routing_number).to eql("121145307")
    end
  end

  it "creates an Account number for a Bank Account" do
    body = { description: "Travel Checking Account Number" }

    stub_post("bank-accounts/#{bank_account_id}/account-numbers", body: body, fixture: "account_numbers/retrieve")

    client.account_numbers.create(bank_account_id: bank_account_id, params: body).tap do |accn|
      expect(accn).to be_a(ColumnApi::AccountNumber)
      expect(accn.account_number).to eql("256783259046169")
    end
  end
end
