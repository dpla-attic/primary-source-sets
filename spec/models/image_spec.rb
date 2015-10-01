require 'rails_helper'

describe Image, type: :model do

  let(:attributes) { attributes_for(:image_factory) }

  it_behaves_like 'media asset'

  it 'is invalid without size' do
    attributes[:size] = nil
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
end
