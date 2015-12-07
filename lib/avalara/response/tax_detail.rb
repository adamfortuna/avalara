# encoding: UTF-8

module Avalara
  module Response
    class TaxDetail < Avalara::Types::Stash
      property :taxable, from: :Taxable
      property :rate, from: :Rate
      property :tax, from: :Tax
      property :region, from: :Region
      property :country, from: :Country
      property :juris_type, from: :JurisType
      property :juris_name, from: :JurisName
      property :tax_name, from: :TaxName
    end
  end
end