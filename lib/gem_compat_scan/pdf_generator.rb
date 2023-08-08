require 'prawn'
require 'prawn/table'

module GemCompatScan
  class PDFGenerator
    def self.generate_report(updates, output_path = 'gem_updates_report.pdf')
      Prawn::Document.generate(output_path) do |pdf|
        pdf.text 'Gem Updates Report', size: 18, style: :bold, align: :center
        pdf.move_down 20

        table_data = [['Gem', 'Current Version', 'Latest Version', 'Github URL']]

        updates.each do |update|
          table_data << [
            update[:gem],
            update[:current_version],
            update[:latest_version],
            github_link(update[:github_url], pdf)
          ]
        end

        pdf.table(table_data, header: true, width: pdf.bounds.width) do
          cells.borders = []
          row(0).font_style = :bold
        end
      end
    end

    def self.github_link(github_url, pdf)
      if github_url
        pdf.make_cell(
  :content => "<link href='#{github_url}'>#{github_url}</link>",
  :inline_format => true)
      else
        ''
      end
    end
  end
end
