require 'rails_helper'

describe 'audios/index.html.erb', type: :view do

  before do
    assign(:audios, [create(:audio_factory, file_base: 'file1'),
                     create(:audio_factory, file_base: 'file2')])
  end

  it_behaves_like 'renderable view'

  it 'renders each audio' do
    render
    expect(rendered).to include('file1')
    expect(rendered).to include('file2')
  end
end
