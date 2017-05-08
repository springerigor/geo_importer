Sequel::Model.db = Sequel.postgres(ENV["DATABASE_NAME"],
  host: ENV["DATABASE_HOST"],
  password: ENV["DATABASE_PASSWORD"],
  port: ENV["DATABASE_PORT"],
  user: ENV["DATABASE_USER"]
)

module GeoImporter
  module Models
    class Geolocation < Sequel::Model
      plugin :validation_helpers

      def validate
        super
        validates_presence [:city, :mystery_value]

        validates_unique(:ip_address)
        errors.add(:ip_address, "invalid IP address") unless GeoImporter::Validators::IpValidator.new(ip_address: ip_address).valid?

        errors.add(:country_code, "invalid country code") unless GeoImporter::Validators::CountryCodeValidator.new(country_code: country_code).valid?
        errors.add(:country_name, "invalid country name") unless GeoImporter::Validators::CountryNameValidator.new(country_code: country_code, country_name: country_name).valid?

        errors.add(:latitude, "invalid latitude") unless GeoImporter::Validators::LatitudeValidator.new(latitude: latitude).valid?
        errors.add(:longitude, "invalid longitude") unless GeoImporter::Validators::LongitudeValidator.new(longitude: longitude).valid?
      end
    end
  end
end
