# encoding: UTF-8

module Avalara
  module Response
    class TaxAddress < Avalara::Types::Stash
      property :address, from: :Address
      property :address_code, from: :AddressCode
      property :city, from: :City
      property :country, from: :Country
      property :postal_code, from: :PostalCode
      property :region, from: :Region
      property :tax_region_id, from: :TaxRegionId
      property :juris_code, from: :JurisCode
    end
  end
end