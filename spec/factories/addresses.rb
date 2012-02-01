Factory.define :address, :class => Avalara::Address do |c|
  c.address_code "address_code"
  c.line_1 "line_1"
  c.line_2 "line_2"
  c.line_3 "line_3"
  c.city "city"
  c.region "region"
  c.country "country"
  c.postal_code "postal_code"
  c.latitude "latitude"
  c.longitude "longitude"
  c.tax_region_id "tax_region_id"
end