require 'rails_helper'

describe ImagesController, type: :controller do
  let(:resource) { create(:image_factory) }
  let(:attributes) { attributes_for(:image_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_image_factory) }
  let(:parent) { resource.attachable }

  it_behaves_like 'admin-only route', :index, :show, :new, :edit

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :show, :update
    it_behaves_like 'nested controller', :index, :create, :destroy
    it_behaves_like 'redirecting controller', :create

    context 'attached to source' do
      let(:parent) { create(:source_factory) }
      let(:resource) { create(:image_factory, attachable: parent) }

      it_behaves_like 'nested controller', :index, :create, :destroy
      it_behaves_like 'redirecting controller', :create
    end
  end
end
