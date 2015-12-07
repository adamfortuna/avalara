Factory.define :detail_level, class: Avalara::Request::DetailLevel do |c|
  c.line "line"
  c.summary "summary"
  c.document "document"
  c.tax "tax"
  c.diagnostic "diagnostic"
end