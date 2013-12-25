# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serveit/version'

Gem::Specification.new do |spec|
  spec.name          = "serveit"
  spec.version       = Serveit::VERSION
  spec.authors       = ["Jared Grippe"]
  spec.email         = ["jared@deadlyicon.com"]
  spec.description   = %q{serveit}
  spec.summary       = %q{serveit}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack'
  spec.add_dependency 'rack-contrib'
  spec.add_dependency 'shotgun'
  spec.add_dependency 'thin'
  spec.add_dependency 'pry'
  spec.add_dependency 'haml'
  spec.add_dependency 'sass'
  spec.add_dependency 'compass'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
