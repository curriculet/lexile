require 'spec_helper'

describe Lexile::Configuration do

  before do
    set_testing_configuration
  end

  describe '.configure' do
    Lexile::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        Lexile.configure do |config|
          if key == :timeout
            config.send("#{key}=", 10)
            expect(Lexile.send(key)).to eq 10
          else
            config.send("#{key}=", key)
            expect(Lexile.send(key)).to eq key
          end
        end
      end
    end
  end

  describe "default values" do
    before{ Lexile.reset! }
    Lexile::Configuration::VALID_CONFIG_KEYS.each do |key|
      describe ".#{key}" do
        it 'should return the default value' do
          expect(Lexile.send(key)).to eq Lexile::Configuration.const_get("DEFAULT_#{key.upcase}")
        end
      end
    end
  end
end
