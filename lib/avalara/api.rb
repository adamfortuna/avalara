# encoding: UTF-8
require 'httparty'

module Avalara
  class API
    include HTTParty
    headers 'Accept' => 'application/json', 'Content-Type' => 'text/json'
    format :json
    parser Parser

    def self.headers_for(length)
      { 'Date' => Time.now.httpdate(), 'User-Agent' => user_agent_string,  "Content-Length" => length.to_s }
    end
    
    private 
    
    def self.user_agent_string
      "avalara/#{Avalara::VERSION} (Rubygems; Ruby #{RUBY_VERSION} #{RUBY_PLATFORM})"
    end
  end
end

