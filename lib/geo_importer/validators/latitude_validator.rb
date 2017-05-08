module GeoImporter
  module Validators
    class LatitudeValidator
      def initialize(latitude:)
        @latitude = latitude
      end

      def valid?
        @latitude.is_a?(Numeric) && @latitude >= -90 && @latitude <= 90
      end
    end
  end
end
