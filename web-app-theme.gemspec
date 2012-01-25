# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'web-app-theme/version'

Gem::Specification.new do |s|
  s.name        = 'web-app-theme'
  s.version     = WebAppTheme::VERSION
  s.authors     = ['Andrea Franz']
  s.email       = ['andrea@gravityblast.com']
  s.homepage    = 'http://github.com/pilu/web-app-theme'
  s.summary     = %q{Web app theme generator}
  s.description = %q{Web app theme generator for rails projects}

  s.rubyforge_project = 'web-app-theme'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_rubygems_version = '>= 1.3.6'

  s.add_runtime_dependency 'rails', '~> 3.2.0'
  s.add_runtime_dependency 'thor',  '~> 0.14'

  s.add_development_dependency 'bundler', '~> 1.0.0'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'cucumber-rails'
  s.add_development_dependency 'aruba'
  s.add_development_dependency 'sqlite3'

  s.extra_rdoc_files = %w[MIT-LICENSE README.md]
end
