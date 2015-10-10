
module ZencoderAuthentication
  extend ActiveSupport::Concern

  included do
    http_basic_authenticate_with name: Settings.zencoder.notification_user,
                                 password: Settings.zencoder.notification_pass
  end
end
