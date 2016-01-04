require 'rails_helper'

describe 'audios/show.html.erb', type: :view do

  let(:audio) { create(:audio_factory) }

  before do
    assign(:audio, audio)
  end

  it_behaves_like 'renderable view'

  it 'renders the audio' do
    render
    expect(rendered).to include(audio.file_base)
  end
end
