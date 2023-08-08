require 'spec_helper'
require 'gem_compat_scan/pdf_generator' # Load the PDFGenerator class

RSpec.describe GemCompatScan::PDFGenerator do
  describe '.generate_report' do
    let(:output_path) { 'test_report.pdf' }

    after do
      File.delete(output_path) if File.exist?(output_path)
    end

    it 'generates a PDF report with gem updates' do
      updates = [
        { gem: 'gem1', current_version: '1.0', latest_version: '1.1', github_url: 'https://github.com/gem1' },
        { gem: 'gem2', current_version: '2.0', latest_version: '2.1', github_url: 'https://github.com/gem2' }
      ]

      GemCompatScan::PDFGenerator.generate_report(updates, output_path)

      expect(File.exist?(output_path)).to be(true)
    end

    it 'generates a PDF report without GitHub URLs' do
      updates = [
        { gem: 'gem3', current_version: '3.0', latest_version: '3.1', github_url: nil }
      ]

      GemCompatScan::PDFGenerator.generate_report(updates, output_path)

      expect(File.exist?(output_path)).to be(true)
    end
  end

end
