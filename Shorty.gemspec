# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "Shorty/version"

Gem::Specification.new do |s|
  s.name        = "Shorty"
  s.version     = Shorty::VERSION
  s.authors     = ["da99"]
  s.email       = ["i-hate-spam-45671204@mailinator.com"]
  s.homepage    = "https://github.com/da99/Shorty"
  s.summary     = %q{A DSL to add before/after hooks to method calls.}
  s.description = %q{
    Add before/after hooks to your method calls.  More info. at
    the homepage.
  }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'bacon'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'Bacon_Colored'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'Exit_0'
  
  # Specify any dependencies here; for example:
  # s.add_runtime_dependency 'rest-client'
end
