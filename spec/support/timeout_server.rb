require 'webrick'

class BlackHole
  def self.method_missing(*args)
    self
  end
end

class TimeoutServer < WEBrick::HTTPServer
  CONFIG = {
    BindAddress: '127.0.0.1',
    Port: 5000,
    AccessLog: BlackHole,
    Logger: BlackHole,
    DoNotListen: true
  }.freeze

  def initialize(options = {})
    super(CONFIG)
    mount_proc('/', ->(req, res) {
      sleep 2
    })
  end

  def endpoint
    "http://#{config[:BindAddress]}:#{config[:Port]}"
  end
end
