# -*- encoding: utf-8 -*-
require File.expand_path('../lib/also_validates/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Noah Davis"]
  gem.email         = ["noahd1@yahoo.com"]
  gem.description   = %q{An ActiveModel validator that validates associated models, copying any errors from composed models up to their parent.}
  gem.summary       = %q{An ActiveModel validator that validates associated models, copying any errors from composed models up to their parent.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "also_validates"
  gem.require_paths = ["lib"]
  gem.add_dependency(%q<activemodel>, [">= 3.0.0"])
  gem.version       = AlsoValidates::VERSION
end
