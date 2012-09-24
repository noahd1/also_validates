# -*- encoding: utf-8 -*-
require File.expand_path('../lib/validation_aggregator/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Noah Davis"]
  gem.email         = ["noahd1@yahoo.com"]
  gem.description   = %q{Validate associated models, and aggregate their errors onto the primary model}
  gem.summary       = %q{Aggregate errors onto primary model from associated models}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "validation_aggregator"
  gem.require_paths = ["lib"]
  gem.add_dependency(%q<activemodel>, [">= 3.0.0"])
  gem.version       = ValidationAggregator::VERSION
end
