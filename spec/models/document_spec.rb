require 'rails_helper'

describe Document, type: :model do
  let(:attributes) { attributes_for(:document_factory) }
  it_behaves_like 'media asset'

  it 'is invalid without file_name' do
    attributes[:file_name] = nil
    expect(described_class.new(attributes)).not_to be_valid
  end
end
