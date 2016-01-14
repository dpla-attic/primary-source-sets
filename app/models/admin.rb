##
# Admin -- administrative user
#
# Most functionality is handled by Devise, with some overridden or custom
# methods that allow for account creations to trigger email confirmations that
# prompt users for passwords.
#
# @see https://github.com/plataformatec/devise/wiki/How-To:-Override-confirmations-so-users-can-pick-their-own-passwords-as-part-of-confirmation-activation
#
class Admin < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable, :confirmable,
         :recoverable, :registerable

  ##
  # Determine whether to validate the presence of the password.
  #
  # This comes into play when a record is being saved with a new password and
  # a confirmation token, after having originally been saved without a
  # password, pending confirmation.
  #
  # @see Devise::Models::Validatable
  def password_required?
    if !persisted?
      # Password is not required for new, unsaved records
      false
    else
      # Evaluate a record that's been saved before, and is in the process of
      # being updated.
      #
      # When the password-set form is being submitted upon confirming an
      # account, the password confirmation token should be set, and, hopefully,
      # the password as well.
      #
      # NOTE: `password' and `password_confirmation' are not persisted fields.
      #       They will only be set during the processing of a form submission.
      #       This can make things extremely confusing in the code below.
      #
      # *true* if there is a password *or* confirmation token, meaning a
      #        validation should take place
      #
      # *false* if neither a password or confirmation token are set, meaning
      #        no validation should take place
      #
      # ... This can be counter-intuitive.  It says to validate the presence
      # of a password if a password exists, which seems redundant, but this is
      # the way Devise::Models::Validatable works and is the way the Devise
      # Wiki recommends to do it, per
      # https://github.com/plataformatec/devise/wiki/How-To:-Override-confirmations-so-users-can-pick-their-own-passwords-as-part-of-confirmation-activation
      #
      password_update_assigned? || password_confirmation_update_assigned?
    end
  end

  # New function to set the password without knowing the current
  # password used in our confirmation controller.
  def attempt_set_password(params)
    p = {
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    }
    update_attributes(p)
  end

  # New function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  def only_if_unconfirmed
    pending_any_confirmation { yield }
  end

  private

  ##
  # @see #password_required?
  # @see Devise::Models:Validatable
  def password_update_assigned?
    !password.nil?
  end

  ##
  # @see #password_required?
  # @see
  def password_confirmation_update_assigned?
    !password_confirmation.nil?
  end
end
