require 'rails_helper'

describe 'guides/edit.html.erb', type: :view do
  before { assign(:guide, create(:guide_factory)) }
  it_behaves_like 'renderable view'
end
