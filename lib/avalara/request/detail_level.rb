# encoding: UTF-8
require 'hashie/trash'

module Avalara
  module Request
    class DetailLevel < ::Hashie::Trash
    
      property :Line, :from => :line
      property :Summary, :from => :summary
      property :Document, :from => :document
      property :Tax, :from => :tax
      property :Diagnostic, :from => :diagnostic
    end
  end
end