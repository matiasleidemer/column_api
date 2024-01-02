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

    def delete(bank_account_id:)
      delete_request("bank-accounts/#{bank_account_id}")
      true
    end

    def history(bank_account_id:, from_date:, to_date:)
      params = { from_date: from_date.strftime("%Y-%m-%d"), to_date: to_date.strftime("%Y-%m-%d") }

      BankAccount.new get_request("bank-accounts/#{bank_account_id}/history", params: params).body
    end
  end
end
