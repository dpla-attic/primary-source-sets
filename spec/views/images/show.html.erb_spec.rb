require 'rails_helper'

describe 'images/show.html.erb', type: :view do

  let(:image) { create(:image_factory) }

  before do
    assign(:image, image)
  end

  it 'renders the image' do
    render
    expect(rendered).to include(image.file_base)
  end
end
