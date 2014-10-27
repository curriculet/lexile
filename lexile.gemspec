# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lexile/version'

Gem::Specification.new do |spec|
  spec.name          = "lexile"
  spec.version       = Lexile::VERSION

  spec.authors       = ["Mauricio Alvarez"]
  spec.email         = ["mauricio@curriculet.com"]
  spec.date          = "2014-10-25"
  spec.description   = "A gem for the Lexile® database API "
  spec.summary       = "A gem to find a book's Lexile DB entry by name or ISBN13"
  spec.homepage      = "https://github.com/curriculet/lexile"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty", "~> 0.10"
  spec.add_runtime_dependency "hashie", "~> 2.0.0"
end
