require 'rails_helper'

describe 'source_sets/show.html.erb', type: :view do

  let(:source_set) { create(:source_set_factory) }

  before do
    assign(:source_set, source_set)
    assign(:type, 'set')
  end

  describe 'posters/show.html.erb', type: :view do
    it_behaves_like 'renderable view'
  end
end
