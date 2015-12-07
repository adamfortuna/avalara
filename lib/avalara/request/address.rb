# encoding: UTF-8

module Avalara
  module Request
    class Address < Avalara::Types::Stash
      property :AddressCode, from: :address_code, required: true
      property :Line1, from: :line_1
      property :Line2, from: :line_2
      property :Line3, from: :line_3
      property :City, from: :city
      property :Region, from: :region
      property :Country, from: :country
      property :PostalCode, from: :postal_code
      property :Latitude, from: :latitude
      property :Longitude, from: :longitude
      property :TaxRegionId, from: :tax_region_id
    end
  end
end