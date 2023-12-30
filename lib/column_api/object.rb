# frozen_string_literal: true

require "json"
require "ostruct"

module ColumnApi
  class Object < OpenStruct
    def initialize(attributes)
      super(to_ostruct(attributes))
    end

    def to_ostruct(obj)
      JSON.parse obj.to_json, object_class: OpenStruct
    end
  end
end
