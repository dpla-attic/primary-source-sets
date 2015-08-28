require 'spec_helper'

describe Guide, type: :model do

  it 'belong to a source set' do
    expect(Guide.reflect_on_association(:source_set).macro.should)
      .to eq :belongs_to
  end

  it 'has and belongs to many authors' do
    expect(Guide.reflect_on_association(:authors).macro.should)
      .to eq :has_and_belongs_to_many
  end

  it 'is invalid without name' do
    expect(Guide.new(name: nil)).not_to be_valid
  end
end
