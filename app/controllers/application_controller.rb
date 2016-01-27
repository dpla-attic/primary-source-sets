class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from AccessGranted::AccessDenied do |exception|
    redirect_to new_admin_session_path
  end

  ##
  # `access-granted' is hardcoded to get the logged-in account with a call
  # to #current_user.  We name our model Admin, so we have to make a shim.
  def current_user
    current_admin
  end

  ##
  # Provide a way to check that the user is logged-in and then check the
  # permissions only if this is the case and current_admin returns non-nil.
  #
  # If you just do `authorize!' without the user being logged-in you'll get
  # an exception.
  #
  # We have actions where the permissions should only be checked
  # if the resource is unpublished.
  #
  # @see AccessGranted::Rails::ControllerMethods#authorize!
  def check_login_and_authorize(*args)
    if admin_signed_in?
      authorize! *args
    else
      flash[:alert] = 'You need to be signed in to see that page.'
      redirect_to new_admin_session_path
    end
  end
end
