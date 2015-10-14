require 'rails_helper'

describe SourcesHelper, type: :helper do

  describe '#render_media_asset' do
    it 'renders the correct partial' do
      source = create(:source_factory)
      source.videos << create(:video_factory)
      assign(:source, source)
      expect(helper).to receive(:render).with({ partial: 'video' })
      helper.render_media_asset
    end
  end
end
