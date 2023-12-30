# frozen_string_literal: true

RSpec.describe ColumnApi::Object do
  let(:body) do
    {
      id: "enti_2Q1c",
      person_details: {
        address: { city: "San Francisco" },
        ssn: "565438976"
      },
      verification_status: "VERIFIED"
    }
  end

  it "parses hash objects" do
    described_class.new(body).tap do |obj|
      expect(obj.id).to eql("enti_2Q1c")
      expect(obj.person_details.address.city).to eql("San Francisco")
      expect(obj.person_details.ssn).to eql("565438976")
      expect(obj.verification_status).to eql("VERIFIED")
    end
  end
end
