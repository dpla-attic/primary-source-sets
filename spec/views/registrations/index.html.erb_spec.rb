require 'rails_helper'

describe 'registrations/index.html.erb', type: :view do

  let(:admin) { create(:admin_factory) }
  before { assign(:admins, [admin]) }

  it_behaves_like 'renderable view'

  it 'shows admin email' do
    render
    expect(rendered).to include admin.email
  end

  it 'shows admin username' do
    render
    expect(rendered).to include admin.username
  end

  it 'links to new registration path' do
    render
    expect(rendered).to include new_registration_path
  end

  it 'links to edit admin path' do
    render
    expect(rendered).to include edit_registration_path(admin)
  end
end
