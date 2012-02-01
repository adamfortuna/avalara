# encoding: UTF-8

# To be removed when Crack is updated, see below.
require 'multi_json'
require 'httparty'

module Avalara
  class Parser < ::HTTParty::Parser
    SupportedFormats.merge!({'text/plain' => :json})


    protected


    ##
    # Private: This was put in place entirely to appease Ruby 1.9.2-p290's more
    # strict YAML parsing, which breaks Crack 0.1.8's JSON decoding.
    #
    # This will be removed when Crack supports decoding the API's returned
    # values.
    #
    def json
      decode_json(body)
    end

    ##
    # Private: This was put in place entirely to appease Ruby 1.9.2-p290's more
    # strict YAML parsing, which breaks Crack 0.1.8's JSON decoding.
    #
    # This will be removed when Crack supports decoding the API's returned
    # values.
    #
    def decode_json(body)
      if body.to_s =~ /^(?:[\d]+|null|true|false)$/
        MultiJson.decode("[#{body}]").first
      else
        MultiJson.decode body
      end
    end
  end
end
