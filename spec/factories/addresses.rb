Factory.define :address, class: Avalara::Request::Address do |c|
  c.address_code 1
  c.line_1 "435 Ericksen Avenue Northeast"
  c.line_2 "#250"
  # c.line_3 "line_3"
  # c.city "city"
  # c.region "region"
  # c.country "country"
  c.postal_code "98110"
  # c.latitude "latitude"
  # c.longitude "longitude"
  # c.tax_region_id "tax_region_id"
end