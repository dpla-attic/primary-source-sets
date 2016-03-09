require 'rails_helper'

describe PostersController, type: :controller do

  let(:source_set) { create(:source_set_factory) }
  let(:guide) { create(:guide_factory) }

  context 'admin not logged in' do
    describe '#index' do
      it 'redirects to admin sign-in path' do
        path = "#{Settings.relative_url_root}#{new_admin_session_path}"
        get :index
        expect(response).to redirect_to path
      end
    end

    describe '#show' do
      it 'redirect to admin sign-in path' do
        path = "#{Settings.relative_url_root}#{new_admin_session_path}"
        get :show, id: guide.slug, type: 'guide'
        expect(response).to redirect_to path
      end
    end
  end

  context 'logged in admin' do
    login_admin

    describe '#index' do
      it 'sets @source_sets variable' do
        get :index
        expect(assigns(:source_sets)).to include source_set
      end

      it 'sets @guides variable' do
        get :index
        expect(assigns(:guides)).to include guide
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe '#show' do
      before do
        source_set.guides << [guide]
      end

      it 'sets @type variable' do
        get :show, id: guide.slug, type: 'guide'
        expect(assigns(:type)).to eq 'guide'
      end

      it 'sets @source_set variable' do
        get :show, id: guide.slug, type: 'guide'
        expect(assigns(:source_set)).to eq source_set
      end

      it 'sets @guide variable' do
        get :show, id: guide.slug, type: 'guide'
        expect(assigns(:guide)).to eq guide
      end

      it 'renders the show view' do
        get :show, id: guide.slug, type: 'guide'
        expect(response).to render_template :show
      end
    end
  end
end
