require 'rails_helper'

describe 'vocabularies/index.html.erb', type: :view do

  before do
    assign(:vocabularies, [create(:vocabulary_factory, name: 'Moomin'),
                           create(:vocabulary_factory, name: 'Snorkmaiden')])
  end

  it 'renders each vocabulary' do
    render
    expect(rendered).to include('Moomin')
    expect(rendered).to include('Snorkmaiden')
  end
end
