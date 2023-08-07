# frozen_string_literal: true

require_relative "lib/gem_compat_scan/version"

Gem::Specification.new do |spec|
  spec.name = "gem_compat_scan"
  spec.version = GemCompatScan::VERSION
  spec.authors = ["Nidhi Sarvaiya"]
  spec.email = ["sarvaiya.nidhi@gmail.com"]

  spec.summary = %q{GemCompatScan: Keep your gems updated and compatible}
  spec.description = %q{GemCompatScan helps Ruby on Rails developers keep their project's dependencies up-to-date and ensure compatibility with their application.}
  spec.homepage      = 'https://github.com/sarvaiyanidhi/gem_compat_scan'
  spec.required_ruby_version = ">= 2.6.0"
  spec.license = 'MIT'


 # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/sarvaiyanidhi/gem_compat_scan"
  spec.metadata["changelog_uri"] = "https://github.com/sarvaiyanidhi/gem_compat_scan/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Add runtime dependencies
  spec.add_runtime_dependency 'bundler'
  spec.add_runtime_dependency 'prawn'
  spec.add_runtime_dependency 'prawn-table'
  spec.add_runtime_dependency 'gems'

  # Optional: Add development dependencies (for testing and development)
  spec.add_development_dependency 'rspec'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
