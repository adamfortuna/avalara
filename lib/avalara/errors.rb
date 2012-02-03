# encoding: UTF-8

module Avalara
  Error = Class.new(StandardError)
  TimeoutError = Class.new(Error)
  NotImplementedError = Class.new(Error)
  ApiError = Class.new(Error)
end