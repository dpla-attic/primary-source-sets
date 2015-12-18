require 'rails_helper'

describe VideoNotificationsController, type: :controller do
  it_behaves_like 'a notification endpoint', Video
end
