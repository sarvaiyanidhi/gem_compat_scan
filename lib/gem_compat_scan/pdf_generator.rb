require 'prawn'
require 'prawn/table'

module GemCompatScan
  class PDFGenerator
    def self.generate_report(updates, output_path = 'gem_updates_report.pdf')
      Prawn::Document.generate(output_path) do |pdf|
        pdf.text 'Gem Updates Report', size: 18, style: :bold, align: :center
        pdf.move_down 20

        table_data = [['Gem', 'Current Version', 'Latest Version', 'New Information']]

        updates.each do |update|
          table_data << [
            update[:gem],
            update[:current_version],
            update[:latest_version],
            update[:new_info] || ''
          ]
        end

        pdf.table(table_data, header: true, width: pdf.bounds.width) do
          cells.borders = []
          row(0).font_style = :bold
        end
      end
    end
  end
end
