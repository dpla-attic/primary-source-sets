require 'rails_helper'

describe 'source_sets/_show.json.erb', type: :view do

  before do
    source_set = create(:source_set_factory)
    source_set.authors << [create(:author_factory)]
    source_set.guides << [create(:guide_factory)]
    source_set.sources << [create(:source_factory)]
    source_set.tags << [create(:tag_factory)]
    assign(:source_set, source_set)
    assign(:authors, source_set.authors)
    assign(:guides, source_set.guides)
    assign(:sources, source_set.sources)
    assign(:tags, source_set.tags)
  end

  it_behaves_like 'renderable view'
  it_behaves_like 'valid json view'
end
