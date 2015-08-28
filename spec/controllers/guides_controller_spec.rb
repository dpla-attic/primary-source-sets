require 'spec_helper'

describe GuidesController, type: :controller do

  let(:guide) { FactoryGirl.create(:guide_factory) }
  let(:source_set) { guide.source_set }

  describe '#show' do

    it 'sets @guide variable' do
      get :show, id: guide.id, source_set_id: source_set.id
      expect(assigns(:guide)).to eq(guide)
    end

    it 'sets @source_set variable' do
      get :show, id: guide.id, source_set_id: source_set.id
      expect(assigns(:source_set)).to eq(source_set)
    end

    it 'renders the :show view' do
      get :show, id: guide.id, source_set_id: source_set.id
      expect(response).to render_template :show
    end
  end

  describe '#create' do

    it 'creates a new guide' do
      source_set
      expect do
        post :create,
             source_set_id: source_set.id,
             guide: attributes_for(:guide_factory)
      end.to change(source_set.guides, :count).by(1)
    end

    it 'redirects to the new guide' do
      source_set
      post :create,
           source_set_id: source_set.id,
           guide: attributes_for(:guide_factory)
      expect(response).to redirect_to [source_set, Guide.last]
    end

    context 'with invalid attributes' do

      it 'does not save new guide' do
        source_set
        expect do
          post :create,
               source_set_id: source_set.id,
               guide: attributes_for(:invalid_guide_factory)
        end.to_not change(source_set.guides, :count)
      end

      it 're-renders :new view' do
        post :create,
             source_set_id: source_set.id,
             guide: attributes_for(:invalid_guide_factory)
        expect(response).to render_template :new
      end
    end
  end

  describe '#update' do

    it 'updates the guide' do
      guide
      patch :update,
            id: guide.id,
            source_set_id: source_set.id,
            guide: { name: 'New name' }
      guide.reload
      expect(guide.name).to eq('New name')
    end

    it 'redirects to the updated guide' do
      patch :update,
            id: guide.id,
            source_set_id: source_set.id,
            guide: { name: 'New name' }
      expect(response).to redirect_to [source_set, guide]
    end

    context 'with invalid attributes' do

      it 'does not update the guide' do
        guide
        valid_name = guide.name
        patch :update,
              id: guide.id,
              source_set_id: source_set.id,
              guide: attributes_for(:invalid_guide_factory)
        guide.reload
        expect(guide.name).to eq(valid_name)
      end

      it 're-renders :edit view' do
        patch :update,
              id: guide.id,
              source_set_id: source_set.id,
              guide: attributes_for(:invalid_guide_factory)
        expect(:response).to render_template :edit
      end
    end
  end

  describe '#destroy' do

    it 'deletes the guide' do
      guide
      expect do
        delete :destroy, id: guide.id, source_set_id: source_set.id
      end.to change(source_set.guides, :count).by(-1)
    end

    it 'redirects to :index view' do
      guide
      delete :destroy, id: guide.id, source_set_id: source_set.id
      expect(response).to redirect_to source_set_url
    end
  end
end
