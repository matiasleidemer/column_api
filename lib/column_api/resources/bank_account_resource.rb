# frozen_string_literal: true

module ColumnApi
  class BankAccountResource < Resource
    def list(params = {})
      response = get_request("bank-accounts", params: params).body
      Collection.from_response(response, key: "bank_accounts", type: BankAccount)
    end

    def retrieve(bank_account_id:)
      BankAccount.new get_request("bank-accounts/#{bank_account_id}").body
    end
  end
end
