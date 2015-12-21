require 'rails_helper'

describe 'vocabularies/show.html.erb', type: :view do
  let(:vocabulary) { create(:vocabulary_factory) }

  before { assign(:vocabulary, vocabulary) }

  it 'renders the vocabulary' do
    render
    expect(rendered).to include(vocabulary.name)
  end
end
