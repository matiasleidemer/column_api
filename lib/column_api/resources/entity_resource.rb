# frozen_string_literal: true

module ColumnApi
  class EntityResource < Resource
    def retrieve(entity_id:)
      res = get_request("entities/#{entity_id}").body

      if res["type"] == "PERSON"
        PersonEntity.new(res)
      else
        BusinessEntity.new(res)
      end
    end
  end
end
