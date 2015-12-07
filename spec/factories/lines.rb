Factory.define :line, class: Avalara::Request::Line do |c|
  c.line_no "1"
  c.destination_code "1"
  c.origin_code "1"
  # c.item_code "item_code"
  # c.tax_code "tax_code"
  # c.customer_usage_type "customer_usage_type"
  c.qty "1"
  c.amount 10
  # c.discounted "discounted"
  # c.tax_included "tax_included"
  # c.ref_1 "ref_1"
  # c.ref_2 "ref_2"
end