require 'dotenv/load'
require 'sequel'

namespace :geo_importer_db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch("DATABASE_URL"))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "#{File.dirname(__FILE__)}/lib/geo_importer/db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "#{File.dirname(__FILE__)}/lib/geo_importer/db/migrations")
    end
  end
end
