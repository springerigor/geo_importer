module GeoImporter
  module Validators
    class LongitudeValidator
      def initialize(longitude:)
        @longitude = longitude
      end

      def valid?
        @longitude.is_a?(Numeric) && @longitude >= -180 && @longitude <= 180
      end
    end
  end
end
