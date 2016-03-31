require 'rails_helper'

describe 'registrations/edit.html.erb', type: :view do

  let(:admin) { create(:admin_factory) }

  before do
    assign(:admin, admin)
    sign_in admin
    # stub devise methods
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:admin])
    allow(view).to receive(:resource).and_return(admin)
    allow(view).to receive(:resource_name).and_return(:admin)
  end

  it_behaves_like 'renderable view'

  it 'shows admin email' do
    render
    expect(rendered).to include admin.email
  end

  it 'shows admin username' do
    render
    expect(rendered).to include admin.username
  end
end
