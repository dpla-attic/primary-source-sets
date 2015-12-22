require 'rails_helper'

describe 'sources/edit.html.erb', type: :view do
  before { assign(:source, create(:source_factory)) }
  it_behaves_like 'renderable view'
end
