require 'rails_helper'

describe 'registrations/new.html.erb', type: :view do

  let(:admin) { create(:admin_factory) }

  before do
    assign(:admin, admin)
    # stub devise methods
    allow(view).to receive(:resource).and_return(admin)
    allow(view).to receive(:resource_name).and_return(:admin)
  end

  it_behaves_like 'renderable view'
end
