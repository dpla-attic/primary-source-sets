require 'rails_helper'

describe Audio, type: :model do

  let(:source) { create(:source_factory) }

  let(:attributes) do
    attributes_for(:audio_factory).merge({ source: source })
  end

  it_behaves_like 'media asset'

  it 'belongs to source' do
    expect(described_class.reflect_on_association(:source).macro.should)
      .to eq :belongs_to
  end
end
