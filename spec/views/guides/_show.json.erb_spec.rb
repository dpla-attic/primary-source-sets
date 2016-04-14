require 'rails_helper'

describe 'guides/_show.json.erb', type: :view do

  before do
    guide = create(:guide_factory)
    guide.authors << [create(:author_factory)]
    assign(:guide, guide)
    assign(:source_set, guide.source_set)
    assign(:authors, guide.authors)
  end

  it_behaves_like 'renderable view'
  it_behaves_like 'valid json view'
end
