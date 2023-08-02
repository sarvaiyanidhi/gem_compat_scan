require 'spec_helper'

describe GemCompatScan::checker do
  describe '.check_updates' do
    it 'returns updates for gems with newer versions available' do
      # Stub the Bundler setup and Gems.info methods
      allow(Bundler.locked_gems).to receive(:specs).and_return([
        instance_double('Gem::Specification', name: 'gem1', version: Gem::Version.new('1.0')),
        instance_double('Gem::Specification', name: 'gem2', version: Gem::Version.new('2.0'))
      ])
      allow(Gems).to receive(:info).with('gem1').and_return('version' => '1.1')
      allow(Gems).to receive(:info).with('gem2').and_return('version' => '2.1')

      updates = GemCompatScan::Checker.check_updates

      expect(updates.size).to eq(2)
      expect(updates).to include(
        { gem: 'gem1', current_version: '1.0', latest_version: '1.1' },
        { gem: 'gem2', current_version: '2.0', latest_version: '2.1' }
      )
    end

    it 'returns emmpty array when no gem updates are available' do
      allow(Bundler.locked_gems).to receive(specs).and_return([
        instance_double('Gem::Specification', name: 'gem3', version: Gem::Version.new('3.0'))
      ])
      allow(Gems).to receive(:info).with('gem3').and_return('version' => '3.0')

      updates = GemCompatScan.check.check_updates
      expect(updates).to be_empty
    end
  end

  describe '.fetch_latest_version' do
    it 'returns the latest version for an existing gem' do
    end

    it 'returns nil for non exisitng gem' do
    end
  end

end