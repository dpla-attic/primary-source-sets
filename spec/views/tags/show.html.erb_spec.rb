require 'rails_helper'

describe 'tags/show.html.erb', type: :view do
  let(:tag) { create(:tag_factory) }

  before { assign(:tag, tag) }

  it_behaves_like 'renderable view'

  it 'renders the tag' do
    render
    expect(rendered).to include(tag.label)
  end
end
