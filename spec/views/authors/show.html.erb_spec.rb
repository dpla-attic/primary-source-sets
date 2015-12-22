require 'rails_helper'

describe 'authors/show.html.erb', type: :view do
  let(:author) { create(:author_factory) }

  before { assign(:author, author) }

  it_behaves_like 'renderable view'

  it 'renders the author' do
    render
    expect(rendered).to include(author.name)
  end
end
