require "hashie/extensions/symbolize_keys"

module Avalara
  module Response
    class Address < Avalara::Types::Stash
      property :result_code, from: :ResultCode
      property :address, from: :Address
      property :messages, from: :Messages

      def initialize(response)
        super(Hashie::Extensions::SymbolizeKeys.symbolize_keys(response))
      end

      def success?
        result_code == "Success"
      end

      def Messages=(msgs)
        self.messages = msgs.map do |message|
          Message.new(message)
        end
      end

      def Address=(addr)
        self.address = AddressLine.new(addr)
      end
    end
  end
end
