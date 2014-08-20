# encoding: UTF-8

module Avalara
  class PayloadError < StandardError
    attr_accessor :payload
  end

  Error = Class.new(StandardError)
  TimeoutError = Class.new(Error)
  NotImplementedError = Class.new(Error)
  ApiError = Class.new(PayloadError)
end
