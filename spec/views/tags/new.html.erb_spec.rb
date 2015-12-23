require 'rails_helper'

describe 'tags/new.html.erb', type: :view do
  before { assign(:tag, build(:tag_factory)) }
  it_behaves_like 'renderable view'
end
