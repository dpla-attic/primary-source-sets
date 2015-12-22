require 'rails_helper'

describe Audio, type: :model do
  let(:attributes) { attributes_for(:audio_factory) }
  it_behaves_like 'media asset'

  it 'is invalid without file_base' do
    attributes[:file_base] = nil
    expect(described_class.new(attributes)).not_to be_valid
  end
end
