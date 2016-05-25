# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puppet_build_util/version'

Gem::Specification.new do |spec|
  spec.name          = "puppet_build_util"
  spec.version       = PuppetBuildUtil::VERSION
  spec.authors       = ["Wang, Dawei"]
  spec.email         = ["dwang@entertainment.com"]
  spec.summary       = %q{Puppet build utility to update metadata.json}
  spec.description   = %q{Update metadata.json version filed with build number and revision}
  spec.homepage      = ""
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "> 10.0"
end
