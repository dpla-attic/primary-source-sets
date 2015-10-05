module ZencoderAuthHelper

  def zc_basic_auth_login
    user = Settings.zencoder.notification_user
    pw = Settings.zencoder.notification_pass
    set_auth(user, pw)
  end

  def zc_bad_basic_auth_login
    user = 'x'
    pw = 'y'
    set_auth(user, pw)
  end

  private

  def set_auth(user, pw)
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
  end
end
