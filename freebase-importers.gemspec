# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'freebase_importers/version'

Gem::Specification.new do |spec|
  spec.name          = "freebase-importers"
  spec.version       = FreebaseImporters::VERSION
  spec.authors       = ["Sam Schenkman-Moore"]
  spec.email         = ["samsm@samsm.com"]
  spec.description   = %q{Some easy importers for Freebase data.}
  spec.summary       = %q{Import Freebase data.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "rest-client"
  spec.add_dependency "addressable"
  spec.add_dependency "json"
  spec.add_dependency "dotenv"
end
