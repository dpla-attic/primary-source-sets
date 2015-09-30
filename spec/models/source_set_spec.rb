require 'rails_helper'

describe SourceSet, type: :model do

  let(:source_set) { FactoryGirl.create(:source_set_factory) }

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

  it 'has many images' do
    expect(SourceSet.reflect_on_association(:images).macro.should)
      .to eq :has_many
  end

  it 'has one large image' do
    expect(SourceSet.reflect_on_association(:large_image).macro.should)
      .to eq :has_one
  end

  it 'recognizes a large image' do
    image = FactoryGirl.create(:image_factory, size: 'large',
                                               attachable: source_set)
    expect(source_set.large_image.id).to eq image.id
  end

  it 'has one thumbnail' do
    expect(SourceSet.reflect_on_association(:thumbnail).macro.should)
      .to eq :has_one
  end

  it 'recognizes a thumbnail image' do
    image = FactoryGirl.create(:image_factory, size: 'thumbnail',
                                               attachable: source_set)
    expect(source_set.thumbnail.id).to eq image.id
  end

  it 'is invalid without name' do
    expect(SourceSet.new(name: nil)).not_to be_valid
  end

  it 'has a slug' do
    expect(SourceSet.create(name: 'Little My').slug).to eq 'little-my'
  end
end
