require 'rails_helper'

describe SourcesHelper, type: :helper do

  let(:source) { create(:source_factory) }

  describe '#render_media_asset' do

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

  describe '#render_thumbnail' do
    it 'renders nothing without main asset' do
      expect(helper.render_thumbnail(source)). to eq nil
    end

    context 'with main asset' do
      before { source.videos << create(:video_factory) }

      it 'renders default image if thumbnail not present' do
        expect(helper.render_thumbnail(source))
          .to include "src=\"/assets/video_thumb.jpg\""
      end

      it 'links to source' do
        expect(helper.render_thumbnail(source))
          .to include "a href=\"/sources/#{source.id}\""
      end

      context 'with thumbnail' do
        let(:thumbnail) { create(:image_factory, size: 'thumbnail') }
        before { source.images << thumbnail }

        it 'renders thumbnail' do
          expect(helper.render_thumbnail(source))
          .to include "src=\"#{Settings.app_scheme}#{Settings.aws.cloudfront_domain}/" \
                      "#{thumbnail.file_name}\""
        end

        it 'renders alt text' do
          expect(helper.render_thumbnail(source))
            .to include "alt=\"#{thumbnail.alt_text}\""
        end
      end
    end
  end
end
