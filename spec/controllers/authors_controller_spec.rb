require 'spec_helper'

describe AuthorsController, type: :controller do

  let(:author) { FactoryGirl. create(:author_factory) }

  describe '#index' do

    it 'set @authors variable' do
      get :index
      expect(assigns(:authors)).to eq([author])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe '#show' do

    it 'sets @author variable' do
      get :show, id: author.id
      expect(assigns(:author)).to eq(author)
    end

    it 'renders the :show view' do
      get :show, id: author.id
      expect(response).to render_template :show
    end
  end

  describe '#create' do

    it 'creates a new author' do
      expect do
        post :create, author: attributes_for(:author_factory)
      end.to change(Author, :count).by(1)
    end

    it 'redirects to the new author' do
      post :create, author: attributes_for(:author_factory)
      expect(response).to redirect_to Author.last
    end

    context 'with invalid attributes' do

      it 'does not save new author' do
        expect do
          post :create, author: attributes_for(:invalid_author_factory)
        end.to_not change(Author, :count)
      end

      it 're-renders :new view' do
        post :create, author: attributes_for(:invalid_author_factory)
        expect(response).to render_template :new
      end
    end
  end

  describe '#update' do

    it 'updates the author' do
      author
      patch :update, id: author.id, author: { name: 'New name' }
      author.reload
      expect(author.name).to eq('New name')
    end

    it 'redirects to the updated author' do
      patch :update, id: author.id, author: { name: 'New name' }
      expect(response).to redirect_to author
    end

    context 'with invalid attributes' do

      it 'does not update the author' do
        author
        valid_name = author.name
        patch :update,
              id: author.id,
              author: attributes_for(:invalid_author_factory)
        author.reload
        expect(author.name).to eq(valid_name)
      end

      it 're-renders :edit view' do
        patch :update,
              id: author.id,
              author: attributes_for(:invalid_author_factory)
        expect(:response).to render_template :edit
      end
    end
  end

  describe '#destroy' do

    it 'deletes the author' do
      author
      expect do
        delete :destroy, id: author.id
      end.to change(Author, :count).by(-1)
    end

    it 'redirects to :index view' do
      author
      delete :destroy, id: author.id
      expect(response).to redirect_to authors_url
    end
  end
end
