# encoding: UTF-8

require 'pathname'

path = Pathname.new(File.expand_path('../../avalara.yml', __FILE__))

if path.exist?
  begin
    AVALARA_CONFIGURATION = YAML.load_file(path)
    Avalara.configure do |config|
      config.username = AVALARA_CONFIGURATION['username'] || abort("Avalara configuration file (#{path}) is missing the username value.")
      config.password = AVALARA_CONFIGURATION['password'] || abort("Avalara configuration file (#{path}) is missing the password value.")
      config.version = AVALARA_CONFIGURATION['version'] if AVALARA_CONFIGURATION.has_key?('version')
      config.endpoint = AVALARA_CONFIGURATION['endpoint'] if AVALARA_CONFIGURATION.has_key?('endpoint')
    end
  rescue NoMethodError
    abort "Avalara configuration file (#{path}) is malformatted or unreadable."
  end
else
  abort "Avalara test configuration (#{path}) not found."
end

module ConfigurationSpecHelpers
  def maintain_contactology_configuration
    before(:each) do
      @_isolated_configuration = Avalara.configuration
      Avalara.configuration = @_isolated_configuration.dup
    end

    after(:each) do
      Avalara.configuration = @_isolated_configuration
    end
  end
end

RSpec.configure do |config|
  config.extend ConfigurationSpecHelpers
end