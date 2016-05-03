require 'rails_helper'

describe SourcesController, type: :controller do

  let(:resource) { create(:source_factory) }
  let(:attributes) { attributes_for(:source_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_source_factory) }
  let(:parent_model) { resource.source_set }

  it_behaves_like 'admin-only route', :new, :edit

  context 'with the user logged-in' do
    login_admin

    it_behaves_like 'basic controller', :update, :show
    it_behaves_like 'nested controller', :index, :create, :destroy
    it_behaves_like 'redirecting controller', :create
  end

  context 'with the user not logged-in' do

    include_examples 'anonymous user redirector',
      :new, :edit, :create, :update, :destroy

    describe '#show' do
      it 'sets @source_set variable' do
        get :show, id: resource.id
        expect(assigns(:source_set)).to eq resource.source_set
      end

      it 'calls ApiQueryer#dpla_items with the DPLA ID' do
        expect(subject).to receive(:dpla_items).with(resource.aggregation)
          .and_return([])
        get :show, id: resource.id
      end

      context 'with a source belonging to an unpublished set' do
        it 'redirects to the sign-in page' do
          get :show, id: resource.id
          expect(response).to redirect_to new_admin_session_path
        end
      end

      context 'with a source belonging to a published set' do
        let(:published_source) { create(:published_source_factory) }

        it 'shows the source' do
          get :show, id: published_source.id
          expect(response).to render_template :show
        end
      end
    end
  end
end
