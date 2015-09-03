require 'spec_helper'

describe SourceSetsController, type: :controller do

  let(:source_set) { FactoryGirl. create(:source_set_factory) }

  describe '#index' do

    it 'set @source_sets variable' do
      get :index
      expect(assigns(:source_sets)).to eq([source_set])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe '#show' do

    it 'sets @source_set variable' do
      get :show, id: source_set.id
      expect(assigns(:source_set)).to eq(source_set)
    end

    it 'renders the :show view' do
      get :show, id: source_set.id
      expect(response).to render_template :show
    end
  end

  describe '#create' do

    it 'creates a new source set' do
      expect do
        post :create, source_set: attributes_for(:source_set_factory)
      end.to change(SourceSet, :count).by(1)
    end

    it 'redirects to the new source set' do
      post :create, source_set: attributes_for(:source_set_factory)
      expect(response).to redirect_to SourceSet.last
    end

    context 'with invalid attributes' do

      it 'does not save new source set' do
        expect do
          post :create, source_set: attributes_for(:invalid_source_set_factory)
        end.to_not change(SourceSet, :count)
      end

      it 're-renders :new view' do
        post :create, source_set: attributes_for(:invalid_source_set_factory)
        expect(response).to render_template :new
      end
    end
  end

  describe '#update' do

    it 'updates the source set' do
      source_set
      patch :update, id: source_set.id, source_set: { name: 'New name' }
      source_set.reload
      expect(source_set.name).to eq('New name')
    end

    it 'redirects to the updated source set' do
      patch :update, id: source_set.id, source_set: { name: 'New name' }
      expect(response).to redirect_to source_set
    end

    context 'with invalid attributes' do

      it 'does not update the source set' do
        source_set
        valid_name = source_set.name
        patch :update,
              id: source_set.id,
              source_set: attributes_for(:invalid_source_set_factory)
        source_set.reload
        expect(source_set.name).to eq(valid_name)
      end

      it 're-renders :edit view' do
        patch :update,
              id: source_set.id,
              source_set: attributes_for(:invalid_source_set_factory)
        expect(:response).to render_template :edit
      end
    end
  end

  describe '#destroy' do

    it 'deletes the source set' do
      source_set
      expect do
        delete :destroy, id: source_set.id
      end.to change(SourceSet, :count).by(-1)
    end

    it 'redirects to :index view' do
      source_set
      delete :destroy, id: source_set.id
      expect(response).to redirect_to source_sets_url
    end
  end
end
