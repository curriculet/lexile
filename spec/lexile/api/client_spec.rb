require 'spec_helper'

describe Lexile::API::Client do

  let(:client){
    set_testing_configuration
    Lexile::API::Client.new( Lexile )
  }

  it "should have a VERSION" do
    Lexile::VERSION.should_not be_nil
  end

  describe 'initialization' do
    describe 'via configure' do
      context "should be initialized by config" do
        before do
          set_testing_configuration
          @cli = Lexile.configure do |c |
                c.username  = lexile_username
                c.password  = lexile_password
                c.testing   = true
          end
          @options_hash = @cli.class.default_options
        end

        it { expect(@cli).to_not be_nil }
        it { expect(@options_hash[:base_uri]).to eq Lexile.api_url }
        it { expect(@options_hash[:default_params]).to be_nil }
        it { expect(@options_hash[:debug_output]).to_not be_nil }
        it { expect(@options_hash[:headers]).to_not be_nil }
        it { expect(@options_hash[:headers]['User-Agent']).to_not be_nil }
      end
    end

    context 'should be initialized via hash' do
      before do
        configuration_hash = {
            endpoint:     'https://example.com',
            api_version:  'v52',
            username:     'my_lexile_username',
            password:     'my_lexile_password',
            testing:      true
        }
        @options_hash = client.class.default_options
        @client = Lexile::API::Client.new( configuration_hash )
      end

      it{ expect(@client).to_not be_nil }
      it{ expect(@options_hash[:base_uri]).to eq 'https://example.com/v52' }
      it{ expect(@options_hash[:default_params]).to be_nil }
      it{ expect(@options_hash[:debug_output]).to_not be_nil }
    end
  end

  describe "get" do
    it "should not raise an exception with response status 200" do
      VCR.use_cassette("errors") do
        expect{ client.get("/book") }.not_to raise_error
      end
    end


    it "should raise Lexile::AuthenticationFailed with response status is 401" do
          VCR.use_cassette("errors") do
            expect{ client.get("/401") }.to raise_error  Lexile::AuthenticationFailed
          end
    end


    it "should raise Lexile::NotFound with response status is 404" do
      VCR.use_cassette("errors") do
        expect{ client.get("/404") }.to raise_error  Lexile::NotFound
      end
    end



    [
      {status: 400, ex: Lexile::BadRequest },
      {status: 401, ex: Lexile::AuthenticationFailed},
      {status: 404, ex: Lexile::NotFound},
      {status: 429, ex: Lexile::TooManyRequests},
      {status: 500, ex: Lexile::ServerError},
      {status: 502, ex: Lexile::Unavailable},
      {status: 503, ex: Lexile::Unavailable},
      {status: 504, ex: Lexile::Unavailable},
      {status: 999, ex: Lexile::UnknownStatusCode}
    ].each do |test_args|
      it "should raise #{test_args[:ex].name} when status code is #{test_args[:status]}" do
        mock = double
        mock.stub(:code){test_args[:status]}
        mock.stub(:headers){ "Some Headers From The  Request"}
        client.class.stub(:get){ mock }
        expect{
          client.get("/something")
        }.to raise_error test_args[:ex]
      end
    end
  end
end
