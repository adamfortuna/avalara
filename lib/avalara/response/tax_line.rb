# encoding: UTF-8

module Avalara
  module Response
    class TaxLine < Avalara::Types::Stash
      property :line_no, :from => :LineNo
      property :tax_code, :from => :TaxCode
      property :taxability, :from => :Taxability
      property :taxable, :from => :Taxable
      property :rate, :from => :Rate
      property :tax, :from => :Tax
      property :tax_details, :from => :TaxDetails
      property :discount, :from => :Discount
      property :tax_calculated, :from => :TaxCalculated
      property :exemption, :from => :Exemption

      def TaxDetails=(tax_details)
        self.tax_details = []
        tax_details.each do |tax_detail|
          self.tax_details << TaxDetail.new(tax_detail)
        end
      end
    end
  end
end