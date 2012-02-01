Factory.define :get_tax_request, :class => Avalara::GetTaxRequest do |c|
  c.customer_code "customer_code"
  c.doc_date "doc_date"
  c.company_code "83"
  c.commit "commit"
  c.customer_usage_type "customer_usage_type"
  c.discount "discount"
  c.doc_code "doc_code"
  c.purchase_order_no "purchase_order_no"
  c.exemption_no "exemption_no"
  c.detail_level
  c.doc_type "doc_type"
  c.payment_date "payment_date"
  c.lines { [Factory.build_via_new(:line), Factory.build_via_new(:line)] }
  c.addresses { [Factory.build_via_new(:address), Factory.build_via_new(:address)] }
  c.reference_code "reference_code"
end