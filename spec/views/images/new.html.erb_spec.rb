require 'rails_helper'

describe 'images/new.html.erb', type: :view do
  before(:each) { assign(:image, build(:image_factory)) }
  it_behaves_like 'renderable new media view'
end
