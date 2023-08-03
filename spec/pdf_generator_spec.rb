require 'spec_helper'
require 'gem_compat_scan/pdf_generator'

describe GemCompatScan::PDFGenerator do
  describe '.generate_report' do
    it 'generates a PDF report with gem updates' do
      updates = [
        { gem: 'gem1', current_version: '1.0', latest_version: '1.1', new_info: 'Added new feature XYZ' },
        { gem: 'gem2', current_version: '2.0', latest_version: '2.1', new_info: 'Bug fixes and performance improvements' }
      ]

      output_path = 'custom_gem_report.pdf'

      # Stub the Prawn::Document.generate method and allow methods inside the block
      allow(Prawn::Document).to receive(:generate).with(output_path).and_yield(instance_double('Prawn::Document', text: nil, move_down: nil))

      GemCompatScan::PDFGenerator.generate_report(updates, output_path)
    end
  end
end
