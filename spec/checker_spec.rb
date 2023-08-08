require 'spec_helper'
require 'gem_compat_scan/checker' # Load the Checker class

RSpec.describe GemCompatScan::Checker do
  describe '.check_updates' do
    it 'returns updates for gems with newer versions available' do
      allow(Bundler.locked_gems).to receive(:specs).and_return([
        instance_double('Gem::Specification', name: 'gem1', version: Gem::Version.new('1.0')),
        instance_double('Gem::Specification', name: 'gem2', version: Gem::Version.new('2.0'))
      ])
      allow(Gems).to receive(:info).with('gem1').and_return('version' => '1.1', 'source_code_uri' => 'https://github.com/gem1')
      allow(Gems).to receive(:info).with('gem2').and_return('version' => '2.1', 'source_code_uri' => 'https://github.com/gem2')

      updates = GemCompatScan::Checker.check_updates

      expect(updates.size).to eq(2)
      expect(updates).to include(
        { gem: 'gem1', current_version: '1.0', latest_version: '1.1', github_url: nil },
        { gem: 'gem2', current_version: '2.0', latest_version: '2.1', github_url: nil }
      )
    end

    it 'returns empty array when no gem updates are available' do
      allow(Bundler.locked_gems).to receive(:specs).and_return([
        instance_double('Gem::Specification', name: 'gem3', version: Gem::Version.new('3.0'))
      ])
      allow(Gems).to receive(:info).with('gem3').and_return('version' => '3.0', 'source_code_uri' => 'https://github.com/gem3')

      updates = GemCompatScan::Checker.check_updates
      expect(updates).to be_empty
    end
  end

  describe '.fetch_latest_version' do
    it 'returns the latest version for an existing gem' do
      allow(Gems).to receive(:info).with('existing_gem').and_return('version' => '1.0')
      latest_version = GemCompatScan::Checker.fetch_latest_version('existing_gem')

      expect(latest_version).to eq('1.0')
    end

    it 'returns nil for non-existing gem' do
      allow(Gems).to receive(:info).with('non_existing_gem').and_raise(Gems::NotFound)
      latest_version = GemCompatScan::Checker.fetch_latest_version('non_existing_gem')

      expect(latest_version).to be_nil
    end
  end

  describe '.fetch_github_url' do
    it 'returns the GitHub URL for an existing gem' do
      allow(Gems).to receive(:info).with('existing_gem').and_return('source_code_uri' => 'https://github.com/existing_gem')
      github_url = GemCompatScan::Checker.fetch_github_url('existing_gem')

      expect(github_url).to eq(nil)
    end

    it 'returns nil for non-existing gem' do
      allow(Gems).to receive(:info).with('non_existing_gem').and_raise(Gems::NotFound)
      github_url = GemCompatScan::Checker.fetch_github_url('non_existing_gem')

      expect(github_url).to be_nil
    end

    it 'returns nil if the source_code_uri is not a GitHub URL' do
      allow(Gems).to receive(:info).with('other_gem').and_return('source_code_uri' => 'https://example.com/other_gem')
      github_url = GemCompatScan::Checker.fetch_github_url('other_gem')

      expect(github_url).to be_nil
    end
  end

  describe '.extract_github_url' do
    it 'returns the GitHub URL from a valid repository URL' do
      repo_url = 'https://github.com/repo_owner/repo_name'
      github_url = GemCompatScan::Checker.extract_github_url(repo_url)

      expect(github_url).to eq('https://github.com/repo_owner/repo_name')
    end

    it 'returns nil if the repository URL format is not recognized' do
      repo_url = 'https://bitbucket.org/repo_owner/repo_name'
      github_url = GemCompatScan::Checker.extract_github_url(repo_url)

      expect(github_url).to be_nil
    end
  end
end
