require 'rails_helper'

describe 'source_sets/index.html.erb', type: :view do

  before do
    create(:source_set_factory, name: 'Moomin')
    create(:source_set_factory, name: 'Snorkmaiden')
    assign(:source_sets, SourceSet.all)
  end

  it 'renders each source set' do
    render
    expect(rendered).to include('Moomin')
    expect(rendered).to include('Snorkmaiden')
  end
end
