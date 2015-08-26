require 'spec_helper'

describe 'source_sets/index.html.erb', type: :view do

  before do
    assign(:source_sets, [create(:source_set_factory, name: 'Moomin'),
                          create(:source_set_factory, name: 'Snorkmaiden')])
  end

  it 'renders each source set' do
    render
    expect(rendered).to include('Moomin')
    expect(rendered).to include('Snorkmaiden')
  end
end
