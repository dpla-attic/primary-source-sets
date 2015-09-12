require 'rails_helper'

describe SourceSetsController, type: :controller do

  let(:resource) { create(:source_set_factory) }
  let(:attributes) { attributes_for(:source_set_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_source_set_factory) }

  it_behaves_like 'admin-only route', :index, :show, :edit, :new

  context 'admin logged in' do
    login_admin

    it_behaves_like 'basic controller', :index, :show, :create, :update,
                                        :destroy
  end
end
