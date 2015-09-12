require 'rails_helper'

describe Source, type: :model do

  let(:source) { create(:source_factory) }

  it 'belongs to a source set' do
    expect(Source.reflect_on_association(:source_set).macro.should)
      .to eq :belongs_to
  end

  it 'has one document' do
    expect(Source.reflect_on_association(:document).macro.should)
      .to eq :has_one
  end

  it 'has one audio' do
    expect(Source.reflect_on_association(:audio).macro.should)
      .to eq :has_one
  end

  it 'has one video' do
    expect(Source.reflect_on_association(:video).macro.should)
      .to eq :has_one
  end

  it 'has many images' do
    expect(Source.reflect_on_association(:images).macro.should)
      .to eq :has_many
  end

  it 'has one large image' do
    expect(Source.reflect_on_association(:large_image).macro.should)
      .to eq :has_one
  end

  it 'recognizes a large image' do
    image = create(:image_factory, size: 'large', attachable: source)
    expect(source.large_image).to eq image
  end

  it 'has one thumbnail' do
    expect(Source.reflect_on_association(:thumbnail).macro.should)
      .to eq :has_one
  end

  it 'recognizes a thumbnail image' do
    image = create(:image_factory, size: 'thumbnail', attachable: source)
    expect(source.thumbnail).to eq image
  end


  it 'is invalid without aggregation' do
    expect(Source.new(aggregation: nil)).not_to be_valid
  end

  describe '#asset' do
    it 'recognizes a large image asset' do
      image = create(:image_factory, size: 'large', attachable: source)
      expect(source.asset).to eq image
    end

    it 'recognizes a document asset' do
      document = create(:document_factory, source: source)
      expect(source.asset).to eq document
    end

    it 'recognizes an audio asset' do
      document = create(:audio_factory, source: source)
      expect(source.asset).to eq document
    end

    it 'recognizes a video asset' do
      document = create(:video_factory, source: source)
      expect(source.asset).to eq document
    end
  end
end
