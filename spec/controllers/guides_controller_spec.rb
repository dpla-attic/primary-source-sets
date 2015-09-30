require 'rails_helper'

describe GuidesController, type: :controller do

  let(:resource) { create(:guide_factory) }
  let(:attributes) { attributes_for(:guide_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_guide_factory) }
  let(:parent) { resource.source_set }

  it_behaves_like 'admin-only route', :index, :show, :new, :edit

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :show, :update
    it_behaves_like 'nested controller', :index, :create, :destroy
  end
end
