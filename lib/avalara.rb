# encoding: UTF-8

require 'avalara/version'
require 'avalara/errors'
require 'avalara/configuration'

require 'avalara/api'

require 'avalara/types'
require 'avalara/request'
require 'avalara/response'

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

  def self.timeout
    configuration.timeout
  end

  def self.timeout=(timeout)
    configuration.timeout = timeout
  end

  def self.read_timeout
    configuration.read_timeout
  end

  def self.read_timeout=(read_timeout)
    configuration.read_timeout = read_timeout
  end

  def self.open_timeout
    configuration.open_timeout
  end

  def self.open_timeout=(open_timeout)
    configuration.open_timeout = open_timeout
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

  def self.geographical_tax(latitude, longitude, sales_amount)
    uri = [
      configuration.endpoint,
      configuration.version,
      "tax",
      "#{latitude},#{longitude}",
      "get"
    ].join("/")

    response = API.get(
      uri,
      {
        :headers    => API.headers_for('0'),
        :query      => {:saleamount => sales_amount},
        :basic_auth => authentication
      }.merge!(net_settings)
    )

    Avalara::Response::Tax.new(response)
  rescue Timeout::Error
    puts "Timed out"
    raise TimeoutError
  end

  def self.get_tax(invoice)
    uri = [endpoint, version, 'tax', 'get'].join('/')

    response = API.post(
      uri,
      {
        :body => invoice.to_json,
        :headers => API.headers_for(invoice.to_json.length),
        :basic_auth => authentication
      }.merge!(net_settings)
    )

    case response.code
    when 200..299
      Response::Invoice.new(response)
    when 400..599
      raise ApiError.new(Response::Invoice.new(response))
    else
      raise ApiError.new(response)
    end
  rescue Timeout::Error => e
    raise TimeoutError.new(e)
  rescue ApiError => e
    raise e
  rescue Exception => e
    raise Error.new(e)
  end

  def self.validate_address(address_hash)
    uri = [endpoint, version, "address", "validate"].join("/")
    response = API.get(
      uri,
      {
        query: address_hash,
        headers: API.headers_for('0'),
        basic_auth: authentication
      }.merge!(net_settings)
    )
    case response.code
    when 200..299
      Response::Address.new(response)
    when 400..599
      fail ApiError.new(Response::Address.new(response))
    else
      fail ApiError.new(response)
    end
  rescue Timeout::Error => e
    raise TimeoutError.new(e)
  end

  private

  def self.net_settings
    settings = {}
    if timeout
      settings[:read_timeout] = timeout
      settings[:open_timeout] = timeout
    end
    settings[:read_timeout] = read_timeout if read_timeout
    settings[:open_timeout] = open_timeout if open_timeout
    settings
  end

  def self.authentication
    { :username => username, :password => password}
  end
end
