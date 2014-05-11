# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'flying_sphinx/version'

Gem::Specification.new do |s|
  s.name        = 'flying-sphinx'
  s.version     = FlyingSphinx::Version
  s.authors     = ['Pat Allan']
  s.email       = 'pat@freelancing-gods.com'
  s.summary     = 'Sphinx in the Cloud'
  s.description = 'Hooks Thinking Sphinx into the Flying Sphinx service'
  s.homepage    = 'https://flying-sphinx.com'

  s.extra_rdoc_files = ['README.textile']
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
  s.executables   = ['flying-sphinx']

  s.add_runtime_dependency 'thinking-sphinx'
  s.add_runtime_dependency 'riddle',        ['>= 1.5.6']
  s.add_runtime_dependency 'multi_json',    ['>= 1.3.0']
  s.add_runtime_dependency 'faraday',       ['>= 0.9']
  s.add_runtime_dependency 'pusher-client', ['~> 0.3']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.14'

  s.post_install_message = <<-MESSAGE
If you're upgrading, you should rebuild your Sphinx setup when deploying:

  $ heroku rake fs:rebuild
MESSAGE
end
