require 'bundler'
require 'gems'

module GemCompatScan
  class Checker
    def self.check_updates
      Bundler.setup # Load Gemfile.lock
      updates = []
      Bundler.locked_gems.specs.each do |spec|
        gem_name = spec.name
        current_version = spec.version.to_s
        latest_version = fetch_latest_version(gem_name)

        if latest_version && latest_version > current_version
          updates << {
            gem: gem_name,
            current_version: current_version,
            latest_version: latest_version
          }
        end
      end
      updates
    end

    def self.fetch_latest_version(gem_name)
      gem_info = Gems.info(gem_name)
      gem_info['version']
    rescue Gems::NotFound
      nil # Return nil if gem is not found
    end
  end
end