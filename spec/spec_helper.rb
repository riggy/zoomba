require 'simplecov'
SimpleCov.start

require 'bundler/setup'
require 'webmock/rspec'
require 'zoomba'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.color = true

  config.before :suite do
    Zoomba.configure do |c|
      c.api_key = 'API_KEY'
      c.api_secret = 'API_SECRET'
    end
  end
end
