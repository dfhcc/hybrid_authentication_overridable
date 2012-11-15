# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hybrid_authentication_overridable/version'

Gem::Specification.new do |gem|
  gem.name          = "hybrid_authentication_overridable"
  gem.version       = HybridAuthenticationOverridable::VERSION
  gem.authors       = ["Scott Pullen"]
  gem.email         = ["s.pullen05@gmail.com"]
  gem.description   = %q{Hybrid Authentication Overrides}
  gem.summary       = %q{Hybrid Authentication Overrides}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'rails', '~> 3.2.8'
  gem.add_development_dependency 'debugger'
  
  gem.add_dependency 'devise'
  gem.add_dependency 'devise_ldap_authenticatable'
end
