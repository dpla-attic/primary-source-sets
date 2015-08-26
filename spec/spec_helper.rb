ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.formatter = :progress
  config.mock_with :rspec

  config.include FactoryGirl::Syntax::Methods

  # use_transactional_fixtures is false to comply with database cleaner configs
  config.use_transactional_fixtures = false
end
