require 'rails_helper'

describe 'videos/show.html.erb', type: :view do

  let(:video) { create(:video_factory) }

  before do
    assign(:video, video)
  end

  it 'renders the video' do
    render
    expect(rendered).to include(video.file_base)
  end
end
