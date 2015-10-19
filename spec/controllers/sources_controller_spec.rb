require 'rails_helper'

describe SourcesController, type: :controller do

  let(:resource) { create(:source_factory) }
  let(:attributes) { attributes_for(:source_factory) }
  let(:invalid_attributes) { attributes_for(:invalid_source_factory) }
  let(:parent) { resource.source_set }

  it_behaves_like 'admin-only route', :new, :edit

  context 'admin logged in' do
    login_admin

    # FIXME: tests in 'basic controller' need to have mocks for
    # @file_base_or_name?
    it_behaves_like 'basic controller', :update #, :show
    it_behaves_like 'nested controller', :index, :create, :destroy
    it_behaves_like 'redirecting controller', :create
  end
end
