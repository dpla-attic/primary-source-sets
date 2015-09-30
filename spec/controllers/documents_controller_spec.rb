require 'rails_helper'

describe DocumentsController, type: :controller do

  let(:resource) { create(:document_factory) }
  let(:attributes) { attributes_for(:document_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_document_factory) }
  let(:parent) { resource.source }

  it_behaves_like 'admin-only route', :index, :show, :new, :edit

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :show, :update
    it_behaves_like 'nested controller', :index, :create, :destroy
  end
end
