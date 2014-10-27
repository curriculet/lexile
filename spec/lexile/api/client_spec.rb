require 'spec_helper'

describe Lexile::API::Client do

  let(:client){
    Lexile::API::Client.new( Lexile )
  }

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
    #
    # Because of the conflict of Excon.stubs with VCR (they do not work at the same time)
    # We created a errors.yml file by hand to simulate stubs that always return the desired error code
    #
    it "should not raise an exception with response status 200" do
      VCR.use_cassette("errors") do
        expect{ client.get("/book") }.not_to raise_error
      end
    end

    it "should raise Lexile::NotFound with response status is 404" do
      VCR.use_cassette("errors") do
        expect{ client.get("/404") }.to raise_error  Lexile::NotFound
      end
    end
  end
end
