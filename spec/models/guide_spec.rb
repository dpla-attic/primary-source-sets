require 'rails_helper'

describe Guide, type: :model do

  it_behaves_like 'authored' do
    let(:resource) { create(:guide_factory) }
  end

  it 'belong to a source set' do
    expect(Guide.reflect_on_association(:source_set).macro).to eq :belongs_to
  end

  it 'is invalid without name' do
    expect(Guide.new(name: nil)).not_to be_valid
  end

  it 'has a slug' do
    expect(Guide.create(name: 'Little My').slug).to eq 'little-my'
  end
end
