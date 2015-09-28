require 'rspec/rails'

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end
