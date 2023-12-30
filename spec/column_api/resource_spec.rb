# frozen_string_literal: true

RSpec.describe ColumnApi::Resource do
  let(:client) { ColumnApi::Client.new(api_key: "fake") }

  it "handles 400 errors" do
    stub_get("entities/noop", fixture: "error_400", status: 400)

    expect { client.entities.retrieve(entity_id: "noop") }
      .to raise_error(ColumnApi::BadRequestError, "Incorrect or missing resource ID format.")
  end

  it "handles 401 errors" do
    stub_get("entities/id", fixture: "error_401", status: 401)

    expect { client.entities.retrieve(entity_id: "id") }
      .to raise_error(ColumnApi::UnauthorizedError, "Unauthorized")
  end
end
