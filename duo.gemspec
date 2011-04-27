$:.push File.expand_path("../lib", __FILE__)
require 'duo/version'

Gem::Specification.new do |s|
  s.name = 'duo'
  s.version = Duo::VERSION
  s.platform = Gem::Platform::RUBY
  s.date = "2011-04-26"
  s.authors = ['Brandon Dimcheff']
  s.email = 'bdimchef-git@wieldim.com'
  s.homepage = 'http://github.com/bdimcheff/duo'
  s.summary = %Q{TODO: one-line summary of your gem}
  s.description = %Q{TODO: detailed description of your gem}
  s.extra_rdoc_files = [
    'LICENSE',
    'README.rdoc',
  ]

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.7')
  s.rubygems_version = '1.3.7'
  s.specification_version = 3

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'bueller'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rcov'
end

