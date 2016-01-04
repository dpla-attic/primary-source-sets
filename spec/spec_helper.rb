require 'simplecov'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.formatter = :progress
  config.mock_with :rspec
end
