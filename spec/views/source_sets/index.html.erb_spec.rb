require 'rails_helper'

describe 'source_sets/index.html.erb', type: :view do

  before do
    create(:source_set_factory, name: 'Moomin')
    create(:source_set_factory, name: 'Snorkmaiden', published: true)
    assign(:published_sets, SourceSet.published_sets)
    assign(:unpublished_sets, SourceSet.unpublished_sets)
  end

  it_behaves_like 'renderable view'

  it 'renders each published source set' do
    render
    expect(rendered).to include('Snorkmaiden')
  end

  it 'does not render unpublished source sets' do
    render
    expect(rendered).not_to include('Moomin')
  end
end
