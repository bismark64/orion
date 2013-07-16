# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'orion/version'

Gem::Specification.new do |spec|
  spec.name          = "orion"
  spec.version       = Orion::VERSION
  spec.authors       = ["Bismark"]
  spec.email         = ["bismark64@gmail.com"]
  spec.description   = "Orion allows you to search and delete files in your system."
  spec.summary   = "Orion allows you to search and delete files in your system"
  spec.homepage      = "https://github.com/bismark64"
  spec.license       = "MIT"

  spec.add_dependency('ruby-progressbar', '>= 1.1.1')

  spec.files         = Dir['lib/**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "factory_girl"
end
