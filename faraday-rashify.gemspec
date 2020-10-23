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
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = 'https://github.com/lostisland/faraday-rashify'
  spec.metadata['source_code_uri'] = 'https://github.com/lostisland/faraday-rashify'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'faraday'
end
