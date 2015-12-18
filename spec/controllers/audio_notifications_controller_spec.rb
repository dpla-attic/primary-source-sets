require 'rails_helper'

describe AudioNotificationsController, type: :controller do
  it_behaves_like 'a notification endpoint', Audio
end
