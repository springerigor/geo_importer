# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geo_importer/version'

Gem::Specification.new do |spec|
  spec.name          = "geo_importer"
  spec.version       = GeoImporter::VERSION
  spec.authors       = ["Igor Springer"]
  spec.email         = ["springerigor@gmail.com"]

  spec.summary       = "A gem responsible for importing raw geolocation data and saving it in a database."
  spec.description   = "A gem written for FindHotel coding challenge."
  spec.homepage      = "https://github.com/springerigor"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"

  # RSpec for testing purpose
  spec.add_development_dependency "rspec"

  # Postgres
  spec.add_runtime_dependency "pg"

  # Sequel for data layer (an alternative for ActiveRecord, it's always nice to try sth new).
  spec.add_runtime_dependency "sequel"

  # Validate IP addresses
  spec.add_runtime_dependency "ipaddress"

  # Validate country name vs country code
  spec.add_runtime_dependency "countries"

  # Keep configuration variable outside the gem code
  spec.add_runtime_dependency "dotenv"
end
