# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

require 'avalara/version'

Gem::Specification.new do |s|
  s.name        = 'avalara'
  s.version     = Avalara::VERSION
  s.authors     = ['Adam Fortuna']
  s.email       = ['adam@envylabs.com']
  s.homepage    = 'https://github.com/adamfortuna/avalara'
  s.summary     = %q{A Ruby interface to the Avalara Tax API}
  s.description = %q{This library provides Ruby calls to interact with the Avalara Tax API}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'hashie',    '3.2.0'
  s.add_dependency 'httparty'
  s.add_dependency 'multi_json'

  s.add_development_dependency 'rspec'
end
