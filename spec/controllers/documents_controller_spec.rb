require 'rails_helper'

describe DocumentsController, type: :controller do

  let(:resource) { create(:document_factory) }
  let(:attributes) { attributes_for(:document_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_document_factory) }

  it_behaves_like 'admin-only route', :index, :show, :new

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :index, :show, :create, :destroy
    it_behaves_like 'media controller', :new, :create
  end
end
