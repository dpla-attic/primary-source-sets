require 'rails_helper'

describe 'authors/edit.html.erb', type: :view do
  before { assign(:author, create(:author_factory)) }
  it_behaves_like 'renderable view'
end
