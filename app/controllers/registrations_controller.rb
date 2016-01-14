
class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication
  before_action :authenticate_admin!

  ##
  # New #index method not defined in Devise::RegistrationsController
  def index
    @admins = Admin.all
  end

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      redirect_to registrations_path
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  ##
  # @see Devise::RegistrationsController#update
  def update
    self.resource = Admin.find(params[:id])
    prev_unconfirmed_email = resource.unconfirmed_email \
      if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = \
          update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      redirect_to registrations_path
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to registrations_path    
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end