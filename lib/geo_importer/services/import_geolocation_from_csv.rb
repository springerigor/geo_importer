module GeoImporter
  module Services
    class ImportGeolocationFromCsv
      def initialize(gelocation_csv_row:, database_connection:)
        @gelocation_csv_row = gelocation_csv_row
        @database_connection = database_connection
        @status = :ok
      end

      def call
        @status = "Record (#{@gelocation_csv_row}) has already been created in DB" unless new_geolocation?
        @status = "Record (#{@gelocation_csv_row}) is invalid (#{initialized_geolocation_record.errors.full_messages})" unless geolocation_valid?

        save_geolocation_to_database if @status == :ok

        { status: @status }
      end

      private

      def save_geolocation_to_database
        initialized_geolocation_record.save
      end

      def new_geolocation?
        GeoImporter::Models::Geolocation.find(ip_address: @gelocation_csv_row['ip_address'])
      end

      def initialized_geolocation_record
        @initialized_geolocation_record ||= GeoImporter::Models::Geolocation.new(
          country_code: @gelocation_csv_row['country_code'],
          country_name: @gelocation_csv_row['country'],
          city: @gelocation_csv_row['city'],
          ip_address: @gelocation_csv_row['ip_address'],
          longitude: @gelocation_csv_row['longitude'],
          latitude: @gelocation_csv_row['latitude'],
          mystery_value: @gelocation_csv_row['mystery_value'],
        )
      end

      def geolocation_valid?
        initialized_geolocation_record.valid?
      end
    end
  end
end
