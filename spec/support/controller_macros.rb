## Common functions to be used in controller tests
module ControllerMacros
  def login_admin
    before(:each) do
      admin = FactoryGirl.create(:admin)
      sign_in admin
    end
  end
end

RSpec.configure do |config|
  config.extend ControllerMacros, type: :controller
end
