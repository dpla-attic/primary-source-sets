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
  end
end
