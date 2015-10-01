require 'rails_helper'

describe ImagesController, type: :controller do
  let(:resource) { create(:image_factory) }
  let(:attributes) { attributes_for(:image_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_image_factory) }

  it_behaves_like 'admin-only route', :index, :show, :new, :edit

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :index, :show, :create, :update,
                                        :destroy
    it_behaves_like 'redirecting controller', :create
  end
end
