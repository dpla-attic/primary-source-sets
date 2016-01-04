require 'rails_helper'

describe 'audios/new.html.erb', type: :view do
  before(:each) { assign(:audio, build(:audio_factory)) }
  it_behaves_like 'renderable new media view'
end
