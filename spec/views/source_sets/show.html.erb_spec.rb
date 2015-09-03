require 'spec_helper'

describe 'source_sets/show.html.erb', type: :view do
  before { assign(:source_set, create(:source_set_factory, name: 'Moomin')) }

  it 'renders the source set' do
    render
    expect(rendered).to include('Moomin')
  end
end
