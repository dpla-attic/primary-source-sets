require 'rails_helper'

describe 'source_sets/_index.json.erb', type: :view do

  before do
    create(:source_set_factory, name: 'Snorkmaiden', published: true)
    assign(:published_sets, SourceSet.published)
  end

  it_behaves_like 'renderable view'
  it_behaves_like 'valid json view'
end
