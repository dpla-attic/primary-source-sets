require 'rails_helper'

describe Vocabulary, type: :model do

  it 'has and belongs to many tags' do
    expect(Vocabulary.reflect_on_association(:tags).macro)
      .to eq :has_and_belongs_to_many
  end

  it 'is invalid without name' do
    expect(Vocabulary.new(name: nil)).not_to be_valid
  end

  it 'is invalid without unique name' do
    create(:vocabulary_factory, name: 'non-unique-name')
    expect(Vocabulary.new(name: 'non-unique-name')).not_to be_valid
  end

  it 'has a slug' do
    expect(Vocabulary.create(name: 'Little My').slug).to eq 'little-my'
  end
end
