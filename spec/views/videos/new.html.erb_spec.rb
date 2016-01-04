require 'rails_helper'

describe 'videos/new.html.erb', type: :view do
  before(:each) { assign(:video, build(:video_factory)) }
  it_behaves_like 'renderable new media view'
end
