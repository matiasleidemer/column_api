# frozen_string_literal: true

module ColumnApi
  class Collection
    attr_reader :data, :has_more

    def self.from_response(response, key:, type:)
      new(
        data: response[key].map do |attrs|
          if type.respond_to?(:from_response)
            type.from_response(attrs)
          else
            type.new(attrs)
          end
        end,
        has_more: response["has_more"]
      )
    end

    def initialize(data:, has_more:)
      @data = data
      @has_more = has_more
    end
  end
end
