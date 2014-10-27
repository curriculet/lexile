require 'spec_helper'

describe Lexile::HTTPError do
  let(:response){
    mock_response = double()
    mock_response.stub(:code){ 259 }
    mock_response.stub(:body){"<html><head></head><body>Hello World!</body></html>"}
    mock_response
  }

  subject{ Lexile::HTTPError.new( response )}

  it "should format correctly as a string" do
    subject.to_s.should match /Lexile::HTTPError/
    subject.to_s.should match /259/
    subject.to_s.should match /Hello World/
  end
end