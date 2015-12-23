require 'rails_helper'

describe 'source_sets/new.html.erb', type: :view do
  before { assign(:source_set, build(:source_set_factory)) }
  it_behaves_like 'renderable view'
end
