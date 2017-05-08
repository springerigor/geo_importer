require 'csv'

module GeoImporter
  module Services
    class ImportGeolocationsFromCsv

    class CsvFileDoesNotExist < StandardError; end

      def initialize(csv_file_path:)
        @csv_file_path = csv_file_path
        @invalid_records_details = []
        @number_of_invalid_records = 0
        @number_of_valid_records = 0
      end

      def call
        puts "Import started at #{Time.now.utc}"

        raise CsvFileDoesNotExist unless File.exist?(file_location)

        import_valid_records

        puts "Import finished at #{Time.now.utc}"
        puts "No. of valid records imported: #{@number_of_valid_records}"
        puts "No. of invalid records: #{@number_of_invalid_records}"
        puts "Details about the invalid ones: #{@invalid_records_details}"
      end

      private

      def file_location
        File.join(File.dirname(File.expand_path(__FILE__)), @csv_file_path)
      end

      def import_valid_records
        CSV.foreach(file_location, headers: true) do |csv_row|
          imported_record = GeoImporter::Services::ImportGeolocationFromCsv.new(
            gelocation_csv_row: csv_row,
            database_connection: @database_connection
          ).call

          if imported_record[:status] == :ok
            @number_of_valid_records += 1
          else
            @number_of_invalid_records += 1
            @invalid_records_details << imported_record[:status]
          end
        end
      end
    end
  end
end
