require 'rails_helper'

describe Source, type: :model do

  let(:source) { create(:source_factory) }

  it 'belongs to a source set' do
    expect(Source.reflect_on_association(:source_set).macro).to eq :belongs_to
  end

  it 'has many attachments' do
    expect(Source.reflect_on_association(:attachments).macro).to eq :has_many
  end

  it 'has many documents' do
    expect(Source.reflect_on_association(:documents).macro).to eq :has_many
  end

  it 'has many audios' do
    expect(Source.reflect_on_association(:audios).macro).to eq :has_many
  end

  it 'has many videos' do
    expect(Source.reflect_on_association(:videos).macro).to eq :has_many
  end

  it 'has many images' do
    expect(Source.reflect_on_association(:images).macro).to eq :has_many
  end

  it 'is invalid without aggregation' do
    expect(Source.new(aggregation: nil)).not_to be_valid
  end

  context 'with related assets' do

    let(:source) do
      source = create(:source_factory)
      source.videos << video
      source.audios << audio
      source.documents << document
      source.images << image
      source
    end

    let(:video) { create(:video_factory) }
    let(:audio) { create(:audio_factory) }
    let(:document) { create(:document_factory) }
    let(:image) { create(:image_factory) }

    it 'recognizes video' do
      expect(source.videos).to eq [video]
    end

    it 'recognizes audio' do
      expect(source.audios).to eq [audio]
    end

    it 'recognizes document' do
      expect(source.documents).to eq [document]
    end

    it 'recognizes image' do
      expect(source.images).to eq [image]
    end

    describe '#assets' do
      it 'returns all attached assets' do
        expect(source.assets).to contain_exactly(video, audio, document, image)
      end

      context 'with nil asset' do
        let(:attachment) do
          create(:attachment, source_id: source.id,
                              asset_id: video.id,
                              asset_type: "Video")
        end

        let(:nil_attachment) do
          create(:attachment, source_id: source.id,
                              asset_id: 'invalid_id',
                              asset_type: "Video")
        end

        it 'does not return nil asset' do
          allow(source).to receive(:attachments)
            .and_return([attachment, nil_attachment])
          expect(source.assets).to contain_exactly(video)
        end
      end
    end
  end

  context 'with multiple image sizes' do

    let(:source) do
      source = create(:source_factory)
      source.images << [small_image, large_image, thumbnail]
      source
    end

    let(:small_image) { create(:image_factory, size: 'small') }
    let(:large_image) { create(:image_factory, size: 'large') }
    let(:thumbnail) { create(:image_factory, size: 'thumbnail') }

    it 'recognizes large images' do
      expect(source.large_images).to eq [large_image]
    end

    it 'recognizes small images' do
      expect(source.small_images).to eq [small_image]
    end

    it 'recognizes thumnails' do
      expect(source.thumbnails).to eq [thumbnail]
    end

    describe '#main_asset' do
      it 'returns large image' do
        expect(source.main_asset).to eq large_image
      end
    end

    describe '#thumbnail' do
      it 'returns the first attached thumbnail' do
        expect(source.thumbnail).to eq thumbnail
      end
    end

    describe '#small_image' do
      it 'returns the first attached small image' do
        expect(source.small_image).to eq small_image
      end
    end
  end
end
