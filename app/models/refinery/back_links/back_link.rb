module Refinery
  module BackLinks
    class BackLink < Refinery::Core::BaseModel

      self.table_name = 'refinery_back_links'

      attr_accessible :old_link, :new_link, :position

      acts_as_indexed :fields => [:old_link, :new_link]

      # validates :old_link, :presence => true, :uniqueness => true
      #
      # validates :new_link, :presence => true

      def self.to_csv
        CSV.generate do |csv|
          csv << column_names
          all.each do |customer|
            csv << customer.attributes.values_at(*column_names)
          end
        end
      end

      def self.import(file)
        spreadsheet = open_spreadsheet(file)
        header = spreadsheet.row(1)
        (2..spreadsheet.last_row).each do |i|
          row = spreadsheet.row(i)
          link = where(:old_link => row.first.to_s).first || new
          link.old_link = row.first
          link.new_link = row.last
          link.save!
        end
      end

      def self.open_spreadsheet(file)
        case File.extname(file.original_filename)
          when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
          when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
          when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
          else raise "Unknown file type: #{file.original_filename}"
        end
      end

    end
  end
end
