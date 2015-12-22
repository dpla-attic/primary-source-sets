require 'rails_helper'

describe 'source_sets/edit.html.erb', type: :view do
  before { assign(:source_set, create(:source_set_factory)) }
  it_behaves_like 'renderable view'
end
