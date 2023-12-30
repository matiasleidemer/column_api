# frozen_string_literal: true

require "faraday"
require "faraday/parse_dates"

require_relative "column_api/version"

module ColumnApi
  autoload :Client, "column_api/client"
  autoload :Object, "column_api/object"
end
