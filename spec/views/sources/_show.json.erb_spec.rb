require 'rails_helper'

describe 'sources/_show.json.erb', type: :view do

  let(:source) { create(:source_factory) }

  before do
    assign(:source, source)
    assign(:source_set, source.source_set)
  end

  it_behaves_like 'renderable view'

  context 'with document asset' do
    before { assign(:main_asset, create(:document_factory)) }
    it_behaves_like 'valid json view'
  end

  context 'with image asset' do
    before { assign(:main_asset, create(:image_factory)) }
    it_behaves_like 'valid json view'
  end

  context 'with audio asset' do
    before { assign(:main_asset, create(:audio_factory)) }
    it_behaves_like 'valid json view'
  end

  context 'with video asset' do
    before { assign(:main_asset, create(:video_factory)) }
    it_behaves_like 'valid json view'
  end
end
