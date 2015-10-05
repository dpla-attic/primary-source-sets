require 'rails_helper'

describe 'videos/index.html.erb', type: :view do

  before do
    assign(:videos, [create(:video_factory, file_base: 'file1', id: 1,
                            transcoding_job: '1'),
                     create(:video_factory, file_base: 'file2', id: 2,
                            transcoding_job: '2')])
  end

  it 'renders each video' do
    render
    expect(rendered).to include('file1')
    expect(rendered).to include('file2')
  end
end
