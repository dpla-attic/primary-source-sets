require 'rails_helper'

describe 'videos/index.html.erb', type: :view do

  before do
    assign(:videos, [create(:video_factory, file_base: 'file1'),
                     create(:video_factory, file_base: 'file2')])
  end

  it 'renders each video' do
    render
    expect(rendered).to include('file1')
    expect(rendered).to include('file2')
  end
end
