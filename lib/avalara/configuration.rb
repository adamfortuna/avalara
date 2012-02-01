# encoding: UTF-8

class Avalara::Configuration

  attr_writer :endpoint
  attr_accessor :password
  attr_accessor :username
  attr_writer :version

  ##
  # Public: Get the API endpoint used by the configuration.  Unless explicitly
  # set, the endpoint will default to the official production endpoint at
  # 'https://avatax.avalara.net'.
  #
  # Returns the String for the API endpoint.
  #
  def endpoint
    @endpoint ||= 'https://rest.avalara.net'
  end

  ##
  # Public: Get the API version. Defaults to 1.0.
  #
  # Returns the String for the API version.
  #
  def version
    @version ||= '1.0'
  end
end
