# frozen_string_literal: true

RSpec.describe ColumnApi::EntityResource do
  let(:client) { ColumnApi::Client.new(api_key: "fake") }

  it "retrieves a Person Entity" do
    stub_get("entities/enti_2Q1ctiJm1NypVqCt8UBC8e4xTfH", fixture: :person_entity)

    client.entities.retrieve(entity_id: "enti_2Q1ctiJm1NypVqCt8UBC8e4xTfH").tap do |entity|
      expect(entity.class).to be(ColumnApi::PersonEntity)
      expect(entity.id).to eql("enti_2Q1ctiJm1NypVqCt8UBC8e4xTfH")
      expect(entity.person_details.date_of_birth).to eql("1985-08-04")
    end
  end

  it "retrieves a Business Entity" do
    stub_get("entities/enti_2Q1fIwKjnf7TmZP37mAuKjWXB2o", fixture: :business_entity)

    client.entities.retrieve(entity_id: "enti_2Q1fIwKjnf7TmZP37mAuKjWXB2o").tap do |entity|
      expect(entity.class).to be(ColumnApi::BusinessEntity)
      expect(entity.id).to eql("enti_2Q1fIwKjnf7TmZP37mAuKjWXB2o")
      expect(entity.business_details.business_name).to eql("Yellen Cocktails LLC")
    end
  end
end
