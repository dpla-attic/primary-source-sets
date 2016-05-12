require 'rails_helper'

describe SourcesController, type: :controller do

  let(:resource) { create(:source_factory) }
  let(:published_source) { create(:published_source_factory) }
  let(:attributes) { attributes_for(:source_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_source_factory) }
  let(:parent_model) { resource.source_set }

  it_behaves_like 'admin-only route', :new, :edit

  context 'with the user logged-in' do
    login_admin

    it_behaves_like 'basic controller', :update, :show
    it_behaves_like 'nested controller', :index, :create, :destroy
    it_behaves_like 'redirecting controller', :create

    describe '#show' do
      describe 'request for json format' do

        context 'with a source belonging to an unpublished set' do
          it 'renders the show json partial' do
            get :show, id: resource.id, format: :json
            expect(response).to render_template(partial: '_show.json.erb')
          end
        end

        context 'with a source belonging to a published set' do
          it 'renders the show json partial' do
            get :show, id: published_source.id, format: :json
            expect(response).to render_template(partial: '_show.json.erb')
          end
        end
      end
    end
  end

  context 'with the user not logged-in' do

    include_examples 'anonymous user redirector',
      :new, :edit, :create, :update, :destroy

    describe '#show' do
      it 'sets @source_set variable' do
        get :show, id: resource.id
        expect(assigns(:source_set)).to eq resource.source_set
      end

      it 'sets @main_asset variable' do
        resource.videos << [create(:video_factory)]
        get :show, id: resource.id
        expect(assigns(:main_asset)).to eq resource.main_asset
      end

      it 'sets @dpla_item variable' do
        # aggregation is not a valid DPLA ID, so expect that DplaItem will
        # return an empty array
        source = create(:source_factory, aggregation: 'xyz')
        get :show, id: source.id
        expect(assigns(:dpla_item)).to eq []
      end

      context 'with a source belonging to an unpublished set' do
        it 'redirects to the sign-in page' do
          get :show, id: resource.id
          expect(response).to redirect_to new_admin_session_path
        end
      end

      context 'with a source belonging to a published set' do
        it 'shows the source' do
          get :show, id: published_source.id
          expect(response).to render_template :show
        end
      end

      describe 'request for json format' do

        context 'with a source belonging to an unpublished set' do
          it 'redirects to the sign-in page' do
            get :show, id: resource.id, format: :json
            expect(response).to redirect_to new_admin_session_path
          end
        end

        context 'with a source belonging to a published set' do
          it 'renders the show json partial' do
            get :show, id: published_source.id, format: :json
            expect(response).to render_template(partial: '_show.json.erb')
          end
        end
      end
    end
  end
end
