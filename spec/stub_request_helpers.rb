# frozen_string_literal: true

module StubRequestHelpers
  def stub_get(path, fixture:, status: 200)
    stub_request(:get, "https://api.column.com/#{path}")
      .to_return(
        status: status,
        body: File.read("spec/fixtures/#{fixture}.json"),
        headers: { "Content-Type" => "application/json" }
      )
  end
end