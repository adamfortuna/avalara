# encoding: UTF-8

require 'spec_helper'

describe Avalara::Configuration do
  let(:configuration) { Avalara::Configuration.new }

  context '#timeout' do
    it 'defaults to nil' do
      configuration.timeout.should == nil
    end

    it 'may be overridden' do
      expect {
        configuration.timeout = 10
      }.to change(configuration, :timeout).to(10)
    end
  end

  context '#open_timeout' do
    it 'defaults to nil' do
      configuration.open_timeout.should == nil
    end

    it 'may be overridden' do
      expect {
        configuration.open_timeout = 10
      }.to change(configuration, :open_timeout).to(10)
    end
  end

  context '#read_timeout' do
    it 'defaults to nil' do
      configuration.read_timeout.should == nil
    end

    it 'may be overridden' do
      expect {
        configuration.read_timeout = 10
      }.to change(configuration, :read_timeout).to(10)
    end
  end

  context '#endpoint' do
    it 'defaults to https://rest.avalara.net' do
      configuration.endpoint.should == 'https://rest.avalara.net'
    end

    it 'may be overridden' do
      expect {
        configuration.endpoint = 'https://example.local/'
      }.to change(configuration, :endpoint).to('https://example.local/')
    end
  end

  context '#version' do
    it 'defaults to 1.0' do
      configuration.version.should == '1.0'
    end

    it 'may be overridden' do
      expect {
        configuration.version = '2.0'
      }.to change(configuration, :version).to('2.0')
    end
  end

  context '#username' do
    it 'is unset by default' do
      configuration.username.should be_nil
    end

    it 'may be set' do
      expect {
        configuration.username = 'abcdefg'
      }.to change(configuration, :username).to('abcdefg')
    end
  end

  context '#password' do
    it 'is unset by default' do
      configuration.password.should be_nil
    end

    it 'may be set' do
      expect {
        configuration.password = 'abcdefg'
      }.to change(configuration, :password).to('abcdefg')
    end
  end
end
