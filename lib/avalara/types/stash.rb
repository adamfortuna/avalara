# encoding: UTF-8

require 'hashie'

module Avalara
  module Types
    ##
    # A Stash is a 'suppressing' Hashie::Trash where keys that are not defined
    # are simply ignored and unavailable to the local object.
    #
    # A Stash is useful when you need to read data from another application,
    # but you only want a predefined subset of the returned data to become
    # available, locally.
    #
    class Stash < ::Hashie::Trash
      include Hashie::Extensions::DeepMerge
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::Coercion

      private

      def property_exists?(property)
        self.class.property?(property.to_sym)
      end
    end
  end
end
