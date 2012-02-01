# encoding: UTF-8
require 'hashie/trash'

module Avalara
  module Response
    class Invoice < ::Hashie::Trash
    
      # Set outgoing
      property :doc_code, :from => :DocCode
      property :doc_date, :from => :DocDate
      property :timestamp, :from => :Timestamp
      property :total_amount, :from => :TotalAmount
      property :total_discount, :from => :TotalDiscount
      property :total_exemption, :from => :TotalExemption
      property :total_taxable, :from => :TotalTaxable
      property :total_tax, :from => :TotalTax
      property :total_tax_calculated, :from => :TotalTaxCalculated
      property :tax_date, :from => :TaxDate
      property :tax_lines, :from => :TaxLines
      property :tax_addresses, :from => :TaxAddresses
      property :result_code, :from => :ResultCode
    
      def TaxLines=(lines)
        self.tax_lines = []
        lines.each do |line|
          self.tax_lines << TaxLine.new(line)
        end
      end
      
      def TaxAddresses=(addresses)
        self.tax_addresses = []
        addresses.each do |address|
          self.tax_addresses << TaxAddress.new(address)
        end
      end
      
    end
  end
end