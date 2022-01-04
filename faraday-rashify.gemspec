# frozen_string_literal: true

require_relative 'lib/faraday/rashify/version'

Gem::Specification.new do |spec|
  spec.name          = 'faraday-rashify'
  spec.version       = Faraday::Rashify::VERSION
  spec.authors       = ['Olle Jonsson']
  spec.email         = ['olle.jonsson@gmail.com']

  spec.summary       = 'A Faraday middleware around rash_alt.'
  spec.description   = 'This middleware was extracted from faraday_middleware.'
  spec.homepage      = 'https://github.com/lostisland/faraday-rashify'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6')

  spec.metadata['homepage_uri'] = 'https://github.com/lostisland/faraday-rashify'
  spec.metadata['source_code_uri'] = 'https://github.com/lostisland/faraday-rashify'

  spec.files = Dir['lib/**/*.rb', 'README.md', 'LICENSE.txt']
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'faraday', '>= 2.0'
end
