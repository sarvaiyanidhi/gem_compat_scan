require 'spec_helper'
require 'gem_compat_scan/pdf_generator'

RSpec.describe GemCompatScan::PDFGenerator do
  describe '.generate_report' do
    let(:output_path) { 'test_report.pdf' }

    after do
      File.delete(output_path) if File.exist?(output_path)
    end

    it 'generates a PDF report with gem updates' do
      updates = [
        { gem: 'gem1', current_version: '1.0', latest_version: '1.1', new_info: 'New info for gem1' },
        { gem: 'gem2', current_version: '2.0', latest_version: '2.1', new_info: 'New info for gem2' }
      ]

      GemCompatScan::PDFGenerator.generate_report(updates, output_path)

      expect(File.exist?(output_path)).to be(true)
    end

    it 'generates a PDF report without new information' do
      updates = [
        { gem: 'gem3', current_version: '3.0', latest_version: '3.1', new_info: nil }
      ]

      GemCompatScan::PDFGenerator.generate_report(updates, output_path)

      expect(File.exist?(output_path)).to be(true)
    end
  end
end
