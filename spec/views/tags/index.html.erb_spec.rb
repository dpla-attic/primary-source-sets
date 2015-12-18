require 'rails_helper'

describe 'tags/index.html.erb', type: :view do

  before do
    assign(:tags, [create(:tag_factory, label: 'Moomin'),
                   create(:tag_factory, label: 'Snorkmaiden')])
  end

  it 'renders each tag' do
    render
    expect(rendered).to include('Moomin')
    expect(rendered).to include('Snorkmaiden')
  end
end
