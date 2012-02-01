Factory.define :line, :class => Avalara::Line do |c|
  c.line_no "line_no"
  c.destination_code "destination_code"
  c.origin_code "origin_code"
  c.item_code "item_code"
  c.tax_code "tax_code"
  c.customer_usage_type "customer_usage_type"
  c.qty "qty"
  c.amount "amount"
  c.discounted "discounted"
  c.tax_included "tax_included"
  c.ref_1 "ref_1"
  c.ref_2 "ref_2"
end