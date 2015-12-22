require 'rails_helper'

describe 'source_sets/show.html.erb', type: :view do

  let(:source_set) { create(:source_set_factory) }
  let(:source) { create(:source_factory, source_set: source_set) }
  let(:guide) { create(:guide_factory, source_set: source_set) }

  before { assign(:source_set, source_set) }

  it_behaves_like 'renderable view'

  it 'renders the source set' do
    render
    expect(rendered).to include(source_set.name)
  end

  it 'shows all its sources' do
    source
    render
    expect(rendered).to include(source.name)
  end

  it 'shows all its guides' do
    guide
    render
    expect(rendered).to include(guide.name)
  end
end
