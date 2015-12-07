# encoding: UTF-8

module Avalara
  module Request
    class DetailLevel < Avalara::Types::Stash
      property :Line, from: :line
      property :Summary, from: :summary
      property :Document, from: :document
      property :Tax, from: :tax
      property :Diagnostic, from: :diagnostic
    end
  end
end