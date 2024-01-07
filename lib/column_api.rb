# frozen_string_literal: true

require "faraday"
require "faraday/parse_dates"

require_relative "column_api/version"
require_relative "column_api/errors"

module ColumnApi
  BASE_URL = "https://api.column.com/"

  autoload :Client, "column_api/client"
  autoload :Object, "column_api/object"
  autoload :Collection, "column_api/collection"
  autoload :Resource, "column_api/resource"

  # Objects
  autoload :AchTransfer, "column_api/objects/ach_transfer"
  autoload :AccountNumber, "column_api/objects/account_number"
  autoload :BankAccount, "column_api/objects/bank_account"
  autoload :BusinessEntity, "column_api/objects/business_entity"
  autoload :PersonEntity, "column_api/objects/person_entity"
  autoload :WireTransfer, "column_api/objects/wire_transfer"

  # Resources
  autoload :AchTransferResource, "column_api/resources/ach_transfer_resource"
  autoload :AccountNumberResource, "column_api/resources/account_number_resource"
  autoload :BankAccountResource, "column_api/resources/bank_account_resource"
  autoload :EntityResource, "column_api/resources/entity_resource"
  autoload :WireTransferResource, "column_api/resources/wire_transfer_resource"
end
