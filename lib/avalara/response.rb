# encoding: UTF-8

module Avalara
  module Response
    autoload :Invoice, 'avalara/response/invoice'
    autoload :TaxLine, 'avalara/response/tax_line'
    autoload :TaxDetail, 'avalara/response/tax_detail'
    autoload :TaxAddress, 'avalara/response/tax_address'
  end
end
