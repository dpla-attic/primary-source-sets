require 'rails_helper'

describe 'images/index.html.erb', type: :view do

  before do
    assign(:images, [create(:image_factory, file_name: 'file1'),
                     create(:image_factory, file_name: 'file2')])
  end

  it 'renders each image' do
    render
    expect(rendered).to include('file1')
    expect(rendered).to include('file2')
  end
end
