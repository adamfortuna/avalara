# encoding: UTF-8

require 'avalara/version'
require 'avalara/errors'
require 'avalara/configuration'

require 'avalara/address'
require 'avalara/line'
require 'avalara/detail_level'
require 'avalara/get_tax_request'

require 'httparty'

module Avalara

  def self.configuration
    @@_configuration ||= Avalara::Configuration.new
    yield @@_configuration if block_given?
    @@_configuration
  end

  def self.configuration=(configuration)
    raise ArgumentError, 'Expected a Avalara::Configuration instance' unless configuration.kind_of?(Configuration)
    @@_configuration = configuration
  end

  def self.configure(&block)
    configuration(&block)
  end
  
  def self.endpoint
    configuration.endpoint
  end
  def self.endpoint=(endpoint)
    configuration.endpoint = endpoint
  end

  def self.username
    configuration.username
  end
  def self.username=(username)
    configuration.username = username
  end

  def self.password
    configuration.password
  end
  def self.password=(password)
    configuration.password = password
  end

  def self.version
    configuration.version
  end
  def self.version=(version)
    configuration.version = version
  end

  # https://rest.avalara.net/1.0/tax/get
  # Request Body
  # {
  # "DocDate": "2011-05-11",
  # "CustomerCode": "CUST1",
  # "Addresses":
  # [
  # {
  # "AddressCode": "1",
  # }
  def self.get_tax(get_tax_request)
    uri = "#{configuration.endpoint}/#{configuration.version}/tax/get"
    response = ::HTTParty.post(uri, {
      :query => get_tax_request,
      :headers => request_headers(get_tax_request.to_s.length.to_s),
      :basic_auth => authentication
    })
  rescue Timeout::Error
    puts "Timed out"
    raise TimeoutError
  end
  
  private
  
  def self.request_headers(length)
    { 'Accept' => 'application/json', 'User-Agent' => user_agent_string, "Content-Type" => 'text/json', "Content-Length" => length }
  end
  
  def self.authentication
    { :username => configuration.username, :password => configuration.password }
  end
  
  def self.user_agent_string
    "avalara/#{Avalara::VERSION} (Rubygems; Ruby #{RUBY_VERSION} #{RUBY_PLATFORM})"
  end
  
end