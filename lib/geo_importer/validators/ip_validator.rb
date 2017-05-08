require "ipaddress"

module GeoImporter
  module Validators
    class IpValidator
      def initialize(ip_address:)
        @ip_address = ip_address
      end

      def valid?
        @ip_address.is_a?(String) && IPAddress.valid?(@ip_address)
      end
    end
  end
end
