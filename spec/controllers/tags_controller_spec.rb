require 'rails_helper'

describe TagsController, type: :controller do
  let(:resource) { create(:tag_factory) }
  let(:attributes) { attributes_for(:tag_factory, label: 'unique label') }
  let(:invalid_attributes) { attributes_for(:invalid_tag_factory) }

  it_behaves_like 'admin-only route', :index, :show, :edit, :new

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :index, :show, :update, :create,
                                        :destroy

    describe '#new' do
      it 'adds source_set_id from param' do
        source_set = create(:source_set_factory)
        get :new, source_set_id: source_set.id
        expect(assigns(:tag).source_set_ids).to contain_exactly(source_set.id)
      end

      it 'adds vocabulary_id from param' do
        vocabulary = create(:vocabulary_factory)
        get :new, vocabulary_id: vocabulary.id
        expect(assigns(:tag).vocabulary_ids).to contain_exactly(vocabulary.id)
      end
    end
  end
end
