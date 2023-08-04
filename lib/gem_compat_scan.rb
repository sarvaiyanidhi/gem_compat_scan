require 'prawn'
require 'bundler'
require 'gem_compat_scan/checker' # Load the Checker class
require 'gem_compat_scan/pdf_generator'

module GemCompatScan
  def self.run
    # Your existing code to scan gem versions and gather updates
    updates = Checker.check_updates

    # Generate the PDF report using Prawn
    PDFGenerator.generate_report(updates)
  end
end