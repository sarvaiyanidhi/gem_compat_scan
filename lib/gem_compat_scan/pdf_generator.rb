require 'prawn'

module GemCompatScan
  class PDFGenerator
    def self.generate_report(updates, output_path = 'gem_updates_report.pdf')
      Prawn::Document.generate(output_path) do |pdf|
        pdf.text 'Gem Updates Report', size: 18, style: :bold, align: :center
        pdf.move_down 20

        updates.each do |update|
          pdf.text "Gem: #{update[:gem]}", size: 14, style: :bold
          pdf.text "Current Version: #{update[:current_version]}"
          pdf.text "Latest Version: #{update[:latest_version]}"

          if update[:new_info]
            pdf.move_down 10
            pdf.text 'New Information:', style: :bold
            pdf.text update[:new_info]
          end

          pdf.move_down 20
        end
      end
    end
  end
end
