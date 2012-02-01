# encoding: UTF-8

module Avalara
  Error = Class.new(StandardError)
  InvalidObjectError = Class.new(Error)
  TimeoutError = Class.new(Error)
end