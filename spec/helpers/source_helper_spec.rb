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

  describe '#render_back_link' do

    let(:guide) { create(:guide_factory) }

    before(:each) do
      allow(controller.request).to receive(:host).and_return 'example.com'
    end

    it 'renders an HTML link' do
      ref = "http://example.com#{Settings.relative_url_root}/guides/#{guide.id}"
      allow(controller.request).to receive(:referer).and_return ref
      expect(helper.render_back_link)
        .to eq "<a href=\"#{ref}\">« back to guide</a>"
    end

    it 'does not render if referer is not present' do
      allow(controller.request).to receive(:referer).and_return nil
      expect(helper.render_back_link).to eq nil
    end

    it 'does not render if referer has outside host' do
      ref = "http://outside.com#{Settings.relative_url_root}/guides/#{guide.id}"
      allow(controller.request).to receive(:referer).and_return ref
      expect(helper.render_back_link).to eq nil
    end

    it 'does not render if referer has outside relative root' do
      ref = "http://example.com/outside_relative_root/guides/#{guide.id}"
      allow(controller.request).to receive(:referer).and_return ref
      expect(helper.render_back_link).to eq nil
    end

    it 'does not render if referrer has no relative root' do
      ref = "http://example.com/"
      allow(controller.request).to receive(:referer).and_return ref
      expect(helper.render_back_link).to eq nil
    end

    it 'does not render if referer controller is neither sets nor guides' do
      ref = "http://example.com#{Settings.relative_url_root}/videos"
      allow(controller.request).to receive(:referer).and_return ref
      expect(helper.render_back_link).to eq nil
    end

    it 'does not render if referer action is not show' do
      ref = "http://example.com#{Settings.relative_url_root}/sets"
      allow(controller.request).to receive(:referer).and_return ref
      expect(helper.render_back_link).to eq nil
    end
  end
end
