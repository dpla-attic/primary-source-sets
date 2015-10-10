require 'rails_helper'

describe 'images/show.html.erb', type: :view do

  let(:image) { create(:image_factory) }

  before do
    assign(:image, image)
  end

  # FIXME:  view relies on @base_src variable set in controller
  xit 'renders the image' do
    render
    expect(rendered).to include(image.file_name)
  end
end
