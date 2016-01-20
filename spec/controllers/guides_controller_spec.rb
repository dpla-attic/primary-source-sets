require 'rails_helper'

describe GuidesController, type: :controller do

  let(:resource) { create(:guide_factory) }
  let(:attributes) { attributes_for(:guide_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_guide_factory) }
  let(:parent_model) { resource.source_set }

  it_behaves_like 'admin-only route', :new, :edit

  context 'with the user logged-in' do
    login_admin

    it_behaves_like 'basic controller', :show, :update
    it_behaves_like 'nested controller', :index, :create, :destroy
    it_behaves_like 'redirecting controller', :create
  end

  context 'with the user not logged-in' do

    it_behaves_like 'anonymous user redirector',
      :new, :edit, :create, :update, :destroy

    describe '#show' do

      context 'with a guide belonging to an unpublished set' do
        it 'redirects to the sign-in page' do
          get :show, id: resource.id
          expect(response).to redirect_to new_admin_session_path
        end
      end

      context 'with a guide belonging to a published set' do
        let(:published_guide) { create(:published_guide_factory) }

        it 'shows the guide' do
          get :show, id: published_guide.id
          expect(response).to render_template :show
        end
      end

    end
  end
end
