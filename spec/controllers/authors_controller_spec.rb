require 'rails_helper'

describe AuthorsController, type: :controller do

  let(:resource) { create(:author_factory) }
  let(:attributes) { attributes_for(:author_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_author_factory) }

  it_behaves_like 'admin-only route', :index, :show, :edit, :new

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :index, :show, :create, :update,
                                        :destroy
    it_behaves_like 'redirecting controller', :create

    describe '#new' do
      it 'adds source_set_id from param' do
        source_set = create(:source_set_factory)
        get :new, source_set_id: source_set.id
        expect(assigns(:author).source_set_ids)
          .to contain_exactly(source_set.id)
      end

      it 'adds guide_id from param' do
        guide = create(:guide_factory)
        get :new, guide_id: guide.id
        expect(assigns(:author).guide_ids)
          .to contain_exactly(guide.id)
      end
    end
  end
end
