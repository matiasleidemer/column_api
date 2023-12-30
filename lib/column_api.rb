# frozen_string_literal: true

require "faraday"
require "faraday/parse_dates"

require_relative "column_api/version"
require_relative "column_api/errors"

module ColumnApi
  autoload :Client, "column_api/client"
  autoload :Object, "column_api/object"
  autoload :Resource, "column_api/resource"

  # Objects
  autoload :BusinessEntity, "column_api/objects/business_entity"
  autoload :PersonEntity, "column_api/objects/person_entity"

  # Resources
  autoload :EntityResource, "column_api/resources/entity_resource"
end
