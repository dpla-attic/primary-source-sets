require 'rails_helper'

describe 'authors/index.html.erb', type: :view do

  before do
    assign(:authors, [create(:author_factory, name: 'Moomin'),
                      create(:author_factory, name: 'Snorkmaiden')])
  end

  it 'renders each author' do
    render
    expect(rendered).to include('Moomin')
    expect(rendered).to include('Snorkmaiden')
  end
end
