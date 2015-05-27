# encoding: UTF-8

module Avalara
  Error = Class.new(StandardError)
  TimeoutError = Class.new(Error)
  NotImplementedError = Class.new(Error)
  class ApiError < Class.new(Error) do
      def initialize(invoice)
        @message = invoice
      end

      def message
        @message
      end
    end
  end

end
