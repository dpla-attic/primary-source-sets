require 'rails_helper'

describe SourceSetsController, type: :controller do

  let(:resource) { create(:source_set_factory) }
  let(:published) { create(:source_set_factory, published: true) }
  let(:attributes) { attributes_for(:source_set_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_source_set_factory) }

  it_behaves_like 'admin-only route', :edit, :new

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :show, :create, :update, :destroy
    it_behaves_like 'redirecting controller', :create

    describe '#index' do
      it 'sets @published_sets variable' do
        get :index
        expect(assigns(:published_sets)).to eq([published])
      end

      it 'sets @unpublished_sets variable' do
        get :index
        expect(assigns(:unpublished_sets)).to eq([resource])
      end

      context 'with tags' do
        let(:tag) { create(:tag_factory, slug: 'a') }

        before(:each) do
          resource.tags << [tag]
        end

        it 'sets @tags variable' do
          get :index, tags: ['a']
          expect(assigns(:tags)).to eq([tag])
        end

        it 'requests SourceSets with specified tags' do
          expect(SourceSet).to receive(:with_tags).with([tag]).twice
          get :index, tags: ['a']
        end
      end

      it 'only accepts valid tag params' do
        expect(Tag).to receive(:where).with("slug IN (?)", ['abc-DEF'])
        get :index, tags: ['abc-DEF', 'invalid$%']
      end

      it 'sets @order variable' do
        get :index, order: 'recently_added'
        expect(assigns(:order)).to eq 'recently_added'
      end

      it 'requests SourceSets with specified order' do
        relation = double('ActiveRecord::Relation')
        allow(relation).to receive(:with_tags)
        expect(SourceSet).to receive(:order_by).with('recently_added').twice
          .and_return(relation)
        get :index, order: 'recently_added'
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
