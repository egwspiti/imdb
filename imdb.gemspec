# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imdb/version'

Gem::Specification.new do |spec|
  spec.name          = "imdb"
  spec.version       = Imdb::VERSION
  spec.authors       = ["egwspiti"]
  spec.email         = ["egwspiti@users.noreply.github.com"]
  spec.summary       = %q{small gem to fetch and parse data from imdb }
  spec.description   = %q{small gem to fetch and parse data from imdb }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
