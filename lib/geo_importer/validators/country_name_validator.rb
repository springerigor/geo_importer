require 'countries'

module GeoImporter
  module Validators
    class CountryNameValidator
      def initialize(country_code:, country_name:)
        @country_code = country_code
        @country_name = country_name
      end

      def valid?
        @country_name.is_a?(String) && Country[country_code].name == @country_name
      end
    end
  end
end
