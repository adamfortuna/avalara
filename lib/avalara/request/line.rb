# encoding: UTF-8
require 'hashie/trash'

module Avalara
  module Request
    class Line < ::Hashie::Trash
    
      property :LineNo, :from => :line_no, :required => true
      property :DestinationCode, :from => :destination_code, :required => true
      property :OriginCode, :from => :origin_code, :required => true
      property :ItemCode, :from => :item_code
      property :TaxCode, :from => :tax_code
      property :CustomerUsageType, :from => :customer_usage_type
      property :Description, :from => :description
      property :Qty, :from => :qty, :required => true
      property :Amount, :from => :amount, :required => true
      property :Discounted, :from => :discounted
      property :TaxIncluded, :from => :tax_included
      property :Ref1, :from => :ref_1
      property :Ref2, :from => :ref_2
    end
  end
end