require 'rails_helper'

describe SourceSet, type: :model do

  it 'has many sources' do
    expect(SourceSet.reflect_on_association(:sources).macro.should)
      .to eq :has_many
  end

  it 'has many guides' do
    expect(SourceSet.reflect_on_association(:guides).macro.should)
      .to eq :has_many
  end

  it 'has and belongs to many authors' do
    expect(SourceSet.reflect_on_association(:authors).macro.should)
      .to eq :has_and_belongs_to_many
  end

  it 'is invalid without name' do
    expect(SourceSet.new(name: nil)).not_to be_valid
  end

  it 'has a slug' do
    expect(SourceSet.create(name: 'Little My').slug).to eq 'little-my'
  end
end
