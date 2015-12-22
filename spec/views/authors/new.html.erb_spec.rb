require 'rails_helper'

describe 'authors/new.html.erb', type: :view do
  before { assign(:author, build(:author_factory)) }
  it_behaves_like 'renderable view'
end
