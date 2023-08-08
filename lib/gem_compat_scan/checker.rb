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
          github_url = fetch_github_url(gem_name)

          updates << {
            gem: gem_name,
            current_version: current_version,
            latest_version: latest_version,
            github_url: github_url
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

    def self.fetch_github_url(gem_name)
      gem_info = Gems.info(gem_name)
      repo_url = gem_info['source_code_uri']
      extract_github_url(repo_url)
    rescue Gems::NotFound
      nil # Return nil if gem is not found
    end

    def self.extract_github_url(repo_url)
      if repo_url =~ %r{github\.com/([^/]+)/([^/]+)}
        repo_owner = Regexp.last_match(1)
        repo_name = Regexp.last_match(2)
        "https://github.com/#{repo_owner}/#{repo_name}"
      else
        nil # Return nil if the repository URL format is not recognized
      end
    end
  end
end
