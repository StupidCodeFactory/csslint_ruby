# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csslint_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'csslint_ruby'
  spec.version       = CsslintRuby::VERSION
  spec.authors       = ['StupidCodefactory']
  spec.email         = ['ymarquet@gmail.com']
  spec.summary       = %q{Provide an interface to lint css with CSSLint from ruby}
  spec.description   = %q{Provide an interface to lint css with CSSLint from ruby}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'execjs'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
