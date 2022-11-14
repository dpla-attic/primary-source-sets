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
