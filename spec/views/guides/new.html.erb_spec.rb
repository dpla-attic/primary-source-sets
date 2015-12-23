require 'rails_helper'

describe 'guides/new.html.erb', type: :view do
  before do
    guide = build(:guide_factory)
    assign(:guide, guide)
    assign(:source_set, guide.source_set)
  end

  it_behaves_like 'renderable view'
end
