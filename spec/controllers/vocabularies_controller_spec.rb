require 'rails_helper'

describe VocabulariesController, type: :controller do
  let(:resource) { create(:vocabulary_factory) }
  let(:attributes) { attributes_for(:vocabulary_factory, name: 'unique name') }
  let(:invalid_attributes) { attributes_for(:invalid_vocabulary_factory) }

  it_behaves_like 'admin-only route', :index, :show, :edit, :new

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :index, :show, :create, :update,
                                        :destroy
  end
end
