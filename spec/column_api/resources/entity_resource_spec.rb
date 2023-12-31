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

  it "creates a Person Entity" do
    body = { first_name: "Oliver", last_name: "Hockey", email: "oliver@column.com" }

    stub_post("entities/person", body: body, fixture: :create_person_entity)

    client.entities.create_person(body).tap do |entity|
      expect(entity.class).to be(ColumnApi::PersonEntity)
      expect(entity.id).to eql("enti_2Q1ctiJm1NypVqCt8UBC8e4xTfH")
      expect(entity.person_details.email).to eql("oliver@column.com")
    end
  end

  it "creates a Business Entity" do
    body = { ein: "123456789", business_name: "Yellen Cocktails LLC" }

    stub_post("entities/business", body: body, fixture: :create_business_entity)

    client.entities.create_business(body).tap do |entity|
      expect(entity.class).to be(ColumnApi::BusinessEntity)
      expect(entity.id).to eql("enti_2Q1fIwKjnf7TmZP37mAuKjWXB2o")
      expect(entity.business_details.business_name).to eql("Yellen Cocktails LLC")
    end
  end

  it "updates a Person Entity" do
    body = { email: "apis@column.com" }

    stub_patch("entities/person/ID", body: body, fixture: :update_person_entity)

    client.entities.update_person(entity_id: "ID", params: body).tap do |entity|
      expect(entity.class).to be(ColumnApi::PersonEntity)
      expect(entity.person_details.email).to eql("apis@column.com")
    end
  end

  it "updates a Business Entity" do
    body = { business_name: "SquareSoft Games LLC" }

    stub_patch("entities/business/ID", body: body, fixture: :update_business_entity)

    client.entities.update_business(entity_id: "ID", params: body).tap do |entity|
      expect(entity.class).to be(ColumnApi::BusinessEntity)
      expect(entity.business_details.business_name).to eql("SquareSoft Games LLC")
    end
  end

  it "deletes an Entity" do
    stub_delete("entities/ID", fixture: :delete_entity)

    expect(client.entities.delete(entity_id: "ID")).to be true
  end

  it "list Entities" do
    stub_get("entities", query: { limit: 2 }, fixture: :list_entities)

    client.entities.list(limit: 2).tap do |result|
      expect(result.class).to be(ColumnApi::Collection)
      expect(result.data.size).to eql(2)
      expect(result.has_more).to be false
    end
  end
end
