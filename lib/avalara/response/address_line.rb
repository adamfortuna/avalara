module Avalara
  module Response
    class AddressLine < Avalara::Types::Stash
      property :line_1, from: :Line1
      property :line_2, from: :Line2
      property :line_3, from: :Line3
      property :city, from: :City
      property :region, from: :Region
      property :postal_code, from: :PostalCode
      property :country, from: :Country
      property :county, from: :County
      property :fips_code, from: :FipsCode
      property :carrier_route, from: :CarrierRoute
      property :post_net, from: :PostNet
      property :address_type, from: :AddressType
    end
  end
end
