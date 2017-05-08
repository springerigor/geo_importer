Sequel::Model.db = Sequel.connect(ENV["DATABASE_URL"])

module GeoImporter
  module Models
    class Geolocation < Sequel::Model
      plugin :validation_helpers

      def validate
        super
        validates_presence [:city, :mystery_value]

        validates_unique(:ip_address)
        errors.add(:ip_address, "is invalid") unless GeoImporter::Validators::IpValidator.new(ip_address: ip_address).valid?

        errors.add(:country_code, "is invalid") unless GeoImporter::Validators::CountryCodeValidator.new(country_code: country_code).valid?
        errors.add(:country_name, "is invalid") unless GeoImporter::Validators::CountryNameValidator.new(country_code: country_code, country_name: country_name).valid?

        errors.add(:latitude, "is invalid") unless GeoImporter::Validators::LatitudeValidator.new(latitude: latitude).valid?
        errors.add(:longitude, "is invalid") unless GeoImporter::Validators::LongitudeValidator.new(longitude: longitude).valid?
      end
    end
  end
end
