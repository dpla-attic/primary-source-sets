require 'rails_helper'

describe RegistrationsController, type: :controller do

  let(:resource) { create(:unconfirmed_admin_factory) }
  let(:attributes) { attributes_for(:unconfirmed_admin_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_admin_factory) }

  context 'with manager logged in' do
    login_admin
    before do
      # Controller extends Devise class.  Adjust routing.
      request.env['devise.mapping'] = Devise.mappings[:admin]
      # Stub confirmation emails.
      allow_any_instance_of(Admin).to receive(:send_confirmation_instructions)
      # Stub #set_minimum_password_length, which is a magical accessor method
      # in the parent Devise::RegistrationsController, and works in the running
      # app, but which is undefined in the spec test.
      # @see https://github.com/plataformatec/devise/blob/v3.4.1/app/controllers/devise/registrations_controller.rb#L10
      allow(subject).to receive(:set_minimum_password_length)
    end

    it_behaves_like 'basic controller', :index, :edit

    # The "basic controller" shared example doesn't work due to email
    # validation, thus we test #update here
    describe '#update' do
      let(:new_addr) { 'changed@example.org' }

      it 'updates the email by setting it pending confirmation' do
        patch :update, id: resource.id,
                           admin: { email: 'changed@example.org' }
        resource.reload
        expect(resource.unconfirmed_email).to eq new_addr
        # This is considered proof that the update happened.  Other fields
        # like the confirmation token ones are expected to be covered by
        # Devise's tests.
      end

      it 'updates the status' do
        patch :update, id: resource.id,
              admin: { status: 'manager' }
        resource.reload
        expect(resource.status).to eq 'manager'
      end

      it 'updates the username' do
        patch :update, id: resource.id, admin: { username: 'u' }
        resource.reload
        expect(resource.username).to eq 'u'
      end

      context 'with an invalid email address' do
        it 'does not update the record' do
          patch :update, id: resource.id, admin: { email: 'x' }
          resource.reload
          expect(resource.unconfirmed_email).not_to eq('x')
        end
        it 're-renders the :edit view' do
          patch :update, id: resource.id, admin: { email: 'x' }
          expect(response).to render_template :edit
        end
      end
    end

    # The "basic controller" shared example doesn't work due to the redirect
    # situation described below.
    describe '#destroy' do
      it 'deletes the resource' do
        resource
        expect do
          delete :destroy, id: resource.id
        end.to change(resource.class, :count).by(-1)
      end

      # The redirect below is to registrations_path instead of
      # admins_path, which is what "basic controller" example would do
      it 'redirects to the registrations (admins) page' do
        resource
        delete :destroy, id: resource.id
        expect(response).to redirect_to registrations_path
      end
    end

    # This is like the "redirecting controller" example but it has to
    # redirect to registrations_path instead of the nonexistent admins_path.
    describe '#create' do
      before(:each) do
        Admin.destroy(Admin.find(resource.id)) if
          Admin.where(id: resource.id).present?
      end

      it 'creates a new resource' do
        count = resource.class.count
        post :create, admin: attributes
        expect(resource.class.count).to eq(count + 1)
      end

      it 'redirects to the new registrations (admins) listing' do
        post :create, { admin: attributes }
        expect(response).to redirect_to registrations_path
      end

      context 'with invalid attributes' do
        it 'does not save new resource' do
          expect do
            post :create, admin: invalid_attributes
          end.to change(Admin, :count).by(0)
        end
        it 're-renders the :new view' do
          post :create, { admin: invalid_attributes }
          expect(response).to render_template :new
        end
      end
    end

    describe '#edit' do
      it 'renders the :edit view' do
        get :edit, id: resource.id
        expect(response).to render_template :edit
      end
    end
  end

  # TODO: when permissions and roles are added:
  # context 'with non-manager logged in' do
  # end
end
