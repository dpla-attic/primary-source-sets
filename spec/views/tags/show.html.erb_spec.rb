require 'rails_helper'

describe 'tags/show.html.erb', type: :view do
  let(:tag) { create(:tag_factory) }

  before { assign(:tag, tag) }

  it 'renders the tag' do
    render
    expect(rendered).to include(tag.label)
  end
end
