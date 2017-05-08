Sequel.migration do
  change do
    create_table(:geolocations) do
      primary_key :id

      String :ip_address, size: 45, unique: true, null: false # IPV4 and IPV6

      String :country_code, size: 2, null: false
      String :country_name, size: 20, null: false # Duplication of data

      String :city, null: false

      BigDecimal :latitude, size: [9, 6], null: false
      BigDecimal :longitude, size: [9, 6], null: false

      Integer :mystery_value, null: false
    end
  end
end
