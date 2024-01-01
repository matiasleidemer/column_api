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
end
