require 'rails_helper'

describe 'sources/new.html.erb', type: :view do
  before do
    source = build(:source_factory)
    assign(:source, source)
    assign(:source_set, source.source_set)
  end

  it_behaves_like 'renderable view'
end
