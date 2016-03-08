require 'rails_helper'

describe Tag, type: :model do

  it 'has and belongs to many source sets' do
    expect(Tag.reflect_on_association(:source_sets).macro)
      .to eq :has_and_belongs_to_many
  end

  it 'has many sequences' do
    expect(Tag.reflect_on_association(:sequences).macro).to eq :has_many
  end

  it 'has many vocabularies' do
    expect(Tag.reflect_on_association(:vocabularies).macro).to eq :has_many
  end

  it 'is invalid without label' do
    expect(Tag.new(label: nil)).not_to be_valid
  end

  it 'is invalid without unique label' do
    create(:tag_factory, label: 'non-unique-label')
    expect(Tag.new(label: 'non-unique-label')).not_to be_valid
  end

  it 'is invalid without correctly formatted URI' do
    expect(Tag.new(label: 'label', uri: 'not a uri')).not_to be_valid
  end

  it 'is valid if URI is nil' do
    expect(Tag.new(label: 'label', uri: nil)).to be_valid
  end

  it 'has a slug' do
    expect(Tag.create(label: 'Little My').slug).to eq 'little-my'
  end
end
