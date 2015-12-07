module Avalara
  module Response
    class Tax < Avalara::Types::Stash
      property :rate,        from: 'Rate'
      property :tax,         from: 'Tax'
      property :tax_details, from: 'TaxDetails'

      def TaxDetails=(details)
        self.tax_details = details.map { |d| Avalara::Response::TaxDetail.new(d) }
      end
    end
  end
end