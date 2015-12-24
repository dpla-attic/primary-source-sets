require 'rails_helper'

describe SourcesHelper, type: :helper do

  describe '#render_media_asset' do
    let(:source) { create(:source_factory) }

    it 'renders the correct partial' do
      source.videos << create(:video_factory)
      assign(:source, source)
      expect(helper).to receive(:render).with({ partial: 'video' })
      helper.render_media_asset
    end

    it 'renders the right OpenSeadragon viewer parent element' do
      source.images << create(:image_factory)
      assign(:source, source)
      render partial: 'image'
      expect(rendered)
        .to include('<div id="osd-viewer" oncontextmenu="return false;">' \
                    '</div>')
    end
  end
end
