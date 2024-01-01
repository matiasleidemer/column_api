# frozen_string_literal: true

module ColumnApi
  class BankAccountResource < Resource
    def retrieve(bank_account_id:)
      BankAccount.new get_request("bank-accounts/#{bank_account_id}").body
    end
  end
end
