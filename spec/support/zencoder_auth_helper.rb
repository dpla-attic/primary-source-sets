module ZencoderAuthHelper
  def zc_basic_auth_login
    user = Settings.zencoder.notification_user
    pw = Settings.zencoder.notification_pass
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
  end
end
