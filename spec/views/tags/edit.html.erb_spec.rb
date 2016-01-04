require 'rails_helper'

describe 'tags/edit.html.erb', type: :view do
  before { assign(:tag, create(:tag_factory)) }
  it_behaves_like 'renderable view'
end
