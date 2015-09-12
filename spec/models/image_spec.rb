require 'rails_helper'

describe Image, type: :model do

  let(:attributes) { attributes_for(:image_factory) }
  let(:source) { create(:source_factory) }

  it 'belongs to attachable' do
    expect(described_class.reflect_on_association(:attachable).macro.should)
      .to eq :belongs_to
  end

  it 'is invalid without size' do
    attributes[:size] = nil
    expect(described_class.new(attributes)).not_to be_valid
  end

  it 'allows only one of each size per associated attachable' do
    described_class.create(attributes)
    expect(described_class.new(attributes)).not_to be_valid
  end

  it 'is invalid if height is not an integer' do
    attributes[:height] = 'abc'
    expect(described_class.new(attributes)).not_to be_valid
  end

  it 'is invalid if width is not an integer' do
    attributes[:width] = nil
    expect(described_class.new(attributes)).not_to be_valid
  end

  context 'is a large image attached to source' do

    let(:attributes) do
      attributes_for(:image_factory).merge({ attachable: source,
                                             size: 'large' })
    end

    it_behaves_like 'media asset'
  end

  context 'is thumbnail attached to source' do
    context 'source has asset' do

      let(:attributes) do
        attributes_for(:image_factory).merge({ attachable: source,
                                               size: 'thumbnail' })
      end

      it 'is valid' do
        create(:document_factory, source: source)
        expect(described_class.new(attributes)).to be_valid
      end
    end
  end

  describe '#source' do
    it 'returns attachable source' do
      attributes[:attachable] = source
      expect(described_class.new(attributes).source).to eq source
    end

    it 'ignores attachable source_set' do
      expect(described_class.create(attributes).source).to eq nil
    end
  end

  describe '#source_set' do
    it 'returns attachable source set' do
      source_set = create(:source_set_factory)
      attributes[:attachable] = source_set
      expect(described_class.new(attributes).source_set).to eq source_set
    end

    it 'ignores attachable source_set' do
      attributes[:attachable] = source
      expect(described_class.create(attributes).source_set).to eq nil
    end
  end
end
