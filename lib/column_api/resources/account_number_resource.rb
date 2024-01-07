# frozen_string_literal: true

module ColumnApi
  class AccountNumberResource < Resource
    def list(bank_account_id:, params: {})
      response = get_request("bank-accounts/#{bank_account_id}/account-numbers", params: params).body
      Collection.from_response(response, key: "account_numbers", type: AccountNumber)
    end

    def retrieve(account_number_id:)
      AccountNumber.new get_request("account-numbers/#{account_number_id}").body
    end

    def create(bank_account_id:, params: {})
      AccountNumber.new post_request("bank-accounts/#{bank_account_id}/account-numbers", body: params).body
    end
  end
end
