require 'rails_helper'

describe SourceSetsController, type: :controller do

  let(:resource) { create(:source_set_factory) }
  let(:published) { create(:source_set_factory, published: true) }
  let(:attributes) { attributes_for(:source_set_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_source_set_factory) }

  it_behaves_like 'admin-only route', :edit, :new

  context 'with the user logged-in' do
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

      it 'renders the index json partial' do
        get :index, format: :json
        expect(response).to render_template(partial: '_index.json.erb')
      end
    end

    describe '#show' do

      it 'sets @authors variable' do
        resource.authors << [create(:author_factory)]
        get :show, id: resource.id
        expect(assigns(:authors).first).to eq resource.authors.first
      end

      it 'sets @sources variable' do
        create(:source_factory, source_set: resource)
        get :show, id: resource.id
        expect(assigns(:sources).first).to eq resource.sources.first
      end

      it 'sets @guides variable' do
        create(:guide_factory, source_set: resource)
        get :show, id: resource.id
        expect(assigns(:guides).first).to eq resource.guides.first
      end

      it 'sets @tags variable' do
        resource.tags << [create(:tag_factory)]
        get :show, id: resource.id
        expect(assigns(:tags).first).to eq resource.tags.first
      end

      it 'sets @related variable' do
        resource.related_sets << [create(:source_set_factory, published: true)]
        get :show, id: resource.id
        expect(assigns(:related).first).to eq resource.related_sets.first
      end

      describe 'request for json format' do
        context 'with a published set' do
          it 'renders the show json partial' do
            get :show, id: published.id, format: :json
            expect(response).to render_template(partial: '_show.json.erb')
          end
        end

        context 'with an unpublished set' do
          it 'renders the show json partial' do
            get :show, id: resource.id, format: :json
            expect(response).to render_template(partial: '_show.json.erb')
          end
        end
      end
    end
  end

  context 'with the user not logged-in' do

    it_behaves_like 'anonymous user redirector',
      :new, :edit, :create, :update, :destroy

    describe '#show' do

      context 'with an unpublished set' do
        it 'redirects to the sign-in page' do
          get :show, id: resource.id, format: :html
          expect(response).to redirect_to new_admin_session_path
        end
      end

      context 'with a published set' do
        let(:published_set) { create(:published_source_set_factory) }

        it 'shows the set' do
          get :show, id: published_set.id
          expect(response).to render_template :show
        end
      end

      describe 'request for json format' do
        context 'with an unpublished set' do
          it 'redirects to sign-in login' do
            get :show, id: resource.id, format: :json
            expect(response).to redirect_to new_admin_session_path
          end
        end

        context 'with a published set' do
          it 'renders the show json partial' do
            get :show, id: published.id, format: :json
            expect(response).to render_template(partial: '_show.json.erb')
          end
        end
      end
    end
  end
end
