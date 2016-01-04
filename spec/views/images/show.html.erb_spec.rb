require 'rails_helper'

describe 'images/show.html.erb', type: :view do

  let(:image) { create(:image_factory) }

  before do
    assign(:image, image)
  end

  it_behaves_like 'renderable view'

  it 'renders the image' do
    render
    expect(rendered).to include(image.file_name)
  end
end
