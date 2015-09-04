require 'rails_helper'

describe SourcesController, type: :controller do

  let(:source) { FactoryGirl.create(:source_factory) }
  let(:source_set) { source.source_set }

  it_behaves_like "admin-only route", :show, :new, :edit do
    let(:resource) { FactoryGirl.create(:source_factory) }
    let(:request_params) { { source_set_id: resource.source_set.id } }
  end

  context 'admin logged in' do
    login_admin

    describe '#show' do

      it 'sets @source variable' do
        get :show, id: source.id, source_set_id: source_set.id
        expect(assigns(:source)).to eq(source)
      end

      it 'sets @source_set variable' do
        get :show, id: source.id, source_set_id: source_set.id
        expect(assigns(:source_set)).to eq(source_set)
      end

      it 'renders the :show view' do
        get :show, id: source.id, source_set_id: source_set.id
        expect(response).to render_template :show
      end
    end

    describe '#create' do

      it 'creates a new source' do
        source_set
        expect do
          post :create,
               source_set_id: source_set.id,
               source: attributes_for(:source_factory)
        end.to change(source_set.sources, :count).by(1)
      end

      it 'redirects to the new source' do
        source_set
        post :create,
             source_set_id: source_set.id,
             source: attributes_for(:source_factory)
        expect(response).to redirect_to [source_set, Source.last]
      end

      context 'with invalid attributes' do

        it 'does not save new source' do
          source_set
          expect do
            post :create,
                 source_set_id: source_set.id,
                 source: attributes_for(:invalid_source_factory)
          end.to_not change(source_set.sources, :count)
        end

        it 're-renders :new view' do
          post :create,
               source_set_id: source_set.id,
               source: attributes_for(:invalid_source_factory)
          expect(response).to render_template :new
        end
      end
    end

    describe '#update' do

      it 'updates the source' do
        source
        patch :update,
              id: source.id,
              source_set_id: source_set.id,
              source: { name: 'New name' }
        source.reload
        expect(source.name).to eq('New name')
      end

      it 'redirects to the updated source' do
        patch :update,
              id: source.id,
              source_set_id: source_set.id,
              source: { name: 'New name' }
        expect(response).to redirect_to [source_set, source]
      end

      context 'with invalid attributes' do

        it 'does not update the source' do
          source
          valid_aggregation = source.aggregation
          patch :update,
                id: source.id,
                source_set_id: source_set.id,
                source: attributes_for(:invalid_source_factory)
          source.reload
          expect(source.aggregation).to eq(valid_aggregation)
        end

        it 're-renders :edit view' do
          patch :update,
                id: source.id,
                source_set_id: source_set.id,
                source: attributes_for(:invalid_source_factory)
          expect(:response).to render_template :edit
        end
      end
    end

    describe '#destroy' do

      it 'deletes the source' do
        source
        expect do
          delete :destroy, id: source.id, source_set_id: source_set.id
        end.to change(source_set.sources, :count).by(-1)
      end

      it 'redirects to :index view' do
        source
        delete :destroy, id: source.id, source_set_id: source_set.id
        expect(response).to redirect_to source_set_path(source_set)
      end
    end
  end
end
