# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ghee/version"

Gem::Specification.new do |s|
  s.name        = "ghee"
  s.version     = Ghee::VERSION
  s.authors     = ["Ryan Rauh","Jonathan Hoyt"]
  s.email       = ["rauh.ryan@gmail.com"]
  s.homepage    = "http://github.com/rauhryan/ghee"
  s.summary     = %q{Access Github in ruby.}
  s.description = %q{A complete, simple, and intuitive ruby API for all things Github.}

  s.rubyforge_project = "ghee"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'faraday', '~> 0.8'
  s.add_dependency 'faraday_middleware', '~> 0.9'
  s.add_dependency 'hashie', '~> 1.2'
  s.add_dependency 'multi_json', '~> 1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'json_pure'
  s.add_development_dependency 'rspec', '~>2.9.0'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'ZenTest'
  s.add_development_dependency 'autotest-growl'
  s.add_development_dependency 'uuidtools'
end
