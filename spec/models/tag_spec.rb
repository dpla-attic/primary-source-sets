require 'rails_helper'

describe Tag, type: :model do

  it 'has and belongs to many source sets' do
    expect(Tag.reflect_on_association(:source_sets).macro)
      .to eq :has_and_belongs_to_many
  end

  it 'has and belongs to many vocabularies' do
    expect(Tag.reflect_on_association(:vocabularies).macro)
      .to eq :has_and_belongs_to_many
  end

  it 'is invalid without label' do
    expect(Tag.new(label: nil)).not_to be_valid
  end

  it 'is invalid without unique label' do
    create(:tag_factory, label: 'non-unique-label')
    expect(Tag.new(label: 'non-unique-label')).not_to be_valid
  end

  it 'has a slug' do
    expect(Tag.create(label: 'Little My').slug).to eq 'little-my'
  end
end
