require 'spec_helper'

describe ImageViewerHelper, type: :helper do

  describe '#image_viewer' do

    it 'returns a string for a <script> element' do
      expect(helper.image_viewer('x'))
        .to match(/<script>.*<\/script>/)
    end

    context 'having generated options for OpenSeadragon' do
      let(:json_str) {
        helper.image_viewer('x').match(/OpenSeadragon\(({.*?})\)/)[1]
      }
      let(:opts) { JSON.parse(json_str) }

      it 'invokes OpenSeadragon with the right list of parameters' do
        expect(opts.keys)
          .to eq(['id', 'tileSources', 'prefixUrl', 'navImages'])
      end

      it 'invokes OpenSeadragon on the right DOM element' do
        # See app/views/sources/_image.html.erb
        # See app/views/images/show.html.erb
        # See app/assets/stylesheets/primary_source_sets.css
        expect(opts['id']).to eq('osd-viewer')
      end
    end  # context

  end  # describe #image_viewer

end
