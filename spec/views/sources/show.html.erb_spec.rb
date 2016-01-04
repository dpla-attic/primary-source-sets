require 'rails_helper'

describe 'sources/show.html.erb', type: :view do

  let(:source) { create(:source_factory) }

  before do
    assign(:source, source)
    assign(:source_set, source.source_set)
  end

  it_behaves_like 'renderable view'

  it 'renders the source' do
    render
    expect(rendered).to include(source.aggregation)
  end
end
