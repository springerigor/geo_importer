require 'countries'

module GeoImporter
  module Validators
    class CountryNameValidator
      def initialize(country_code:, country_name:)
        @country_code = country_code
        @country_name = country_name
      end

      def valid?
        @country_name.is_a?(String) &&
          iso3166_country &&
          iso3166_country.name == @country_name
      end

      private

      def iso3166_country
        @iso3166_country ||= ISO3166::Country[@country_code]
      end
    end
  end
end
