# frozen_string_literal: true

module StubRequestHelpers
  def stub_get(path, fixture:, status: 200)
    stub_request(:get, "#{ColumnApi::BASE_URL}#{path}")
      .to_return(
        status: status,
        body: File.read("spec/fixtures/#{fixture}.json"),
        headers: { "Content-Type" => "application/json" }
      )
  end

  def stub_post(path, body:, fixture:, status: 200)
    stub_request(:post, "#{ColumnApi::BASE_URL}#{path}")
      .with(body: body)
      .to_return(
        status: status,
        body: File.read("spec/fixtures/#{fixture}.json"),
        headers: { "Content-Type" => "application/json" }
      )
  end
end
