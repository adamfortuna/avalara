# encoding: UTF-8

module Avalara
  module Response
    class Message < Avalara::Types::Stash
      property :summary, from: :Summary
      property :details, from: :Details
      property :refers_to, from: :RefersTo
      property :severity, from: :Severity
      property :source, from: :Source
    end
  end
end