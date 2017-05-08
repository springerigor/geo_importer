$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'geo_importer'

# Require all RSpec support files
#Dir[File.join(__dir__, 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Allow spec tagging
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end
