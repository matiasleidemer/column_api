# frozen_string_literal: true

module ColumnApi
  class EntityResource < Resource
    def self.from_response(response)
      if response["type"] == "PERSON"
        PersonEntity.new(response)
      else
        BusinessEntity.new(response)
      end
    end

    def retrieve(entity_id:)
      EntityResource.from_response get_request("entities/#{entity_id}").body
    end

    def create_person(params)
      PersonEntity.new post_request("entities/person", body: params).body
    end

    def update_person(entity_id:, params:)
      PersonEntity.new patch_request("entities/person/#{entity_id}", body: params).body
    end

    def update_business(entity_id:, params:)
      BusinessEntity.new patch_request("entities/business/#{entity_id}", body: params).body
    end

    def create_business(params)
      BusinessEntity.new post_request("entities/business", body: params).body
    end
  end
end
