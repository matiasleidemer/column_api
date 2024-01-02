# frozen_string_literal: true

module StubRequestHelpers
  def stub_get(path, fixture:, query: {}, status: 200)
    stub_request(:get, "#{ColumnApi::BASE_URL}#{path}")
      .with(query: query)
      .to_return(
        status: status,
        body: File.read("spec/fixtures/#{fixture}.json"),
        headers: { "Content-Type" => "application/json" }
      )
  end

  def stub_post(path, fixture:, body: {}, status: 200)
    stub_request(:post, "#{ColumnApi::BASE_URL}#{path}")
      .with(body: body)
      .to_return(
        status: status,
        body: File.read("spec/fixtures/#{fixture}.json"),
        headers: { "Content-Type" => "application/json" }
      )
  end

  def stub_patch(path, body:, fixture:, status: 200)
    stub_request(:patch, "#{ColumnApi::BASE_URL}#{path}")
      .with(body: body)
      .to_return(
        status: status,
        body: File.read("spec/fixtures/#{fixture}.json"),
        headers: { "Content-Type" => "application/json" }
      )
  end

  def stub_delete(path, fixture:, params: {}, status: 200)
    stub_request(:delete, "#{ColumnApi::BASE_URL}#{path}")
      .with(body: params)
      .to_return(
        status: status,
        body: File.read("spec/fixtures/#{fixture}.json"),
        headers: { "Content-Type" => "application/json" }
      )
  end
end
