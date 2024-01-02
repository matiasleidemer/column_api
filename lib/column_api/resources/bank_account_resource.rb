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

    def create(params)
      BankAccount.new post_request("bank-accounts", body: params).body
    end

    def update(bank_account_id:, params:)
      BankAccount.new patch_request("bank-accounts/#{bank_account_id}", body: params).body
    end
  end
end
