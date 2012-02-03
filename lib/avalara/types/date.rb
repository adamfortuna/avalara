module Avalara
  module Types
    class Date
      def self.coerce(object)
        return object unless object.respond_to?(:strftime)
        return object.strftime("%Y-%m-%d")
      end
    end
  end
end