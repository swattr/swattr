ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../dummy/config/environment", __FILE__)

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require "spec_helper"
require "rspec/rails"
require "pry"
require "byebug"
require "launchy"

Dir[Rails.root.join("../support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.color = true
  config.fail_fast = ENV["FAIL_FAST"] || false
  config.mock_with :rspec
  config.raise_errors_for_deprecations!

  config.infer_spec_type_from_file_location!
end
