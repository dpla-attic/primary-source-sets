##
# Overrides for Devise::ConfirmationsController
#
# Override confirmation behavior to allow creation of accounts without
# passwords, where user action is required to respond to an email and activate
# the account, at which point a password is chosen.
#
# @see https://github.com/plataformatec/devise/wiki/How-To:-Override-confirmations-so-users-can-pick-their-own-passwords-as-part-of-confirmation-activation
#
class ConfirmationsController < Devise::ConfirmationsController
  skip_before_filter :authenticate_user!

  ##
  # Confirm account by updating password
  # PATCH  /admins/confirmation(.:format)
  #
  def update
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        @confirmable.attempt_set_password(params[:admin])
        if @confirmable.valid? and password_match?
          do_confirm
        else
          do_show
          @confirmable.errors.clear  # So that we won't render :new
        end
      else
        @confirmable.errors.add(:email, :password_already_set)
      end
    end

    if !@confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new'
    end
  end

  ##
  # GET /resource/confirmation?confirmation_token=abcdef
  # Show the choose-password form for a new account, or log the user in and
  # redirect, otherwise.
  #
  def show
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    unless @confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new'
    end
  end

  protected

  def with_unconfirmed_confirmable
    digest = Devise.token_generator.digest(
      Admin,
      :confirmation_token,
      params[:confirmation_token]
    )
    @confirmable = Admin.find_or_initialize_with_error_by(
      :confirmation_token,
      digest
    )

    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed { yield }
    end
  end

  def do_show
    @confirmation_token = params[:confirmation_token]
    @requires_password = true
    self.resource = @confirmable
    render 'devise/confirmations/show'
  end

  def do_confirm
    @confirmable.confirm!
    set_flash_message :notice, :confirmed
    sign_in_and_redirect(resource_name, @confirmable)
  end

  private

  def password_match?
    params[:password] == params[:password_confirmation]
  end
end
