# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'darksky/version'

Gem::Specification.new do |spec|
  spec.name          = "darksky"
  spec.version       = Darksky::VERSION
  spec.authors       = ["Yura Tolstik"]
  spec.email         = ["yltsrc@gmail.com"]

  spec.summary       = %q{Ruby gem for retrieving data from the Dark Sky API}
  spec.description   = %q{Ruby gem for retrieving data from the Dark Sky API}
  spec.homepage      = "http://github.com/yltsrc/darksky"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.1"
end
