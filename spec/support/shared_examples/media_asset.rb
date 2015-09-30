shared_examples 'media asset' do

  let(:asset) { described_class.new(attributes) }

  it 'is invalid without file_base' do
    attributes[:file_base] = nil
    expect(described_class.new(attributes)).not_to be_valid
  end

  it 'is invalid without mime_type' do
    attributes[:mime_type] = nil
    expect(described_class.new(attributes)).not_to be_valid
  end

  it 'has an source' do
    expect(asset.source).to be_a Source
  end

  describe 'single asset validation' do

    unless described_class.name == 'Image'
      it 'is invalid if source already has large image asset' do
        create(:image_factory, attachable: source, size: 'large')
        expect(described_class.new(attributes)).not_to be_valid
      end
    end

    unless described_class.name == 'Document'
      it 'is invalid if source already has document asset' do
        create(:document_factory, source: source)
        expect(described_class.new(attributes)).not_to be_valid
      end
    end

    unless described_class.name == 'Audio'
      it 'is invalid if source already has audio asset' do
        create(:audio_factory, source: source)
        expect(described_class.new(attributes)).not_to be_valid
      end
    end

    unless described_class.name == 'Video'
      it 'is invalid if source already has video asset' do
        create(:video_factory, source: source)
        expect(described_class.new(attributes)).not_to be_valid
      end
    end
  end
end
