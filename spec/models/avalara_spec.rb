# encoding: UTF-8

require 'spec_helper'

describe Avalara do
  maintain_contactology_configuration

  let(:configuration) { Avalara.configuration }

  describe '.configuration' do
    it 'yields a Avalara::Configuration instance' do
      Avalara.configuration do |yielded|
        yielded.should be_kind_of Avalara::Configuration
      end
    end

    it 'yields the same configuration instance across multiple calls' do
      Avalara.configuration do |config|
        Avalara.configuration do |config2|
          config.object_id.should == config2.object_id
        end
      end
    end

    it 'returns the configuration when queried' do
      Avalara.configuration do |config|
        Avalara.configuration.object_id.should == config.object_id
      end
    end

    it 'may be explicitly overridden' do
      configuration = Avalara::Configuration.new
      expect {
        Avalara.configuration = configuration
      }.to change(Avalara, :configuration).to(configuration)
    end

    it 'raises an ArgumentError when set to a non-Configuration object' do
      expect {
        Avalara.configuration = 'bad'
      }.to raise_error(ArgumentError)
    end
  end

  describe '.endpoint' do
    it 'returns the configuration endpoint' do
      Avalara.endpoint.should == configuration.endpoint
    end

    it 'overrides the configuration endpoint' do
      expect {
        Avalara.endpoint = 'https://example.local/'
      }.to change(configuration, :endpoint).to('https://example.local/')
    end
  end

  describe '.username' do
    it 'returns the configuration username' do
      configuration.username = 'username'
      Avalara.username.should == configuration.username
    end

    it 'overrides the configuration username' do
      expect {
        Avalara.username = 'username'
      }.to change(configuration, :username).to('username')
    end
  end
  
  describe '.password' do
    it 'returns the configuration password' do
      configuration.password = 'password'
      Avalara.password.should == configuration.password
    end

    it 'overrides the configuration password' do
      expect {
        Avalara.password = 'password'
      }.to change(configuration, :password).to('password')
    end
  end

  describe '.version' do
    it 'returns the configuration version' do
      configuration.version = 'version'
      Avalara.version.should == configuration.version
    end

    it 'overrides the configuration version' do
      expect {
        Avalara.version = 'version'
      }.to change(configuration, :version).to('version')
    end
  end

  describe '.get_tax', focus: true do
    let(:get_tax_request) { Factory.build_via_new(:get_tax_request) }
    subject { Avalara.get_tax(get_tax_request) }
    
    use_vcr_cassette 'get_tax', :record => :new_episodes
    
    it "returns a string" do
      subject.should == "Asdfas"
    end
  end
end