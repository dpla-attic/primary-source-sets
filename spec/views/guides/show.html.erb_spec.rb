require 'rails_helper'

describe 'guides/show.html.erb', type: :view do

  let(:guide) { create(:guide_factory) }

  before do
    assign(:guide, guide)
    assign(:source_set, guide.source_set)
  end

  it_behaves_like 'renderable view'

  it 'renders the guide' do
    render
    expect(rendered).to include(guide.name)
  end
end
