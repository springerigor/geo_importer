module GeoImporter
  module Validators
    class CountryCodeValidator
      def initialize(country_code:)
        @country_code = country_code
      end

      def valid?
        @country_code.is_a?(String) && @country_code.length == 2
      end
    end
  end
end
