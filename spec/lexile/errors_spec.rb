require 'spec_helper'

describe Lexile::HTTPError do
  let(:response){
    mock_response = double()
    mock_response.stub(:code){ 429 }
    mock_response.stub(:headers){ "Some Headers" }
    mock_response
  }

  subject{ Lexile::HTTPError.new( response )}

  it "should format correctly as a string" do
    subject.to_s.should match /Lexile::HTTPError/
    subject.to_s.should match /429/
    subject.to_s.should match /Some Headers/
  end
end