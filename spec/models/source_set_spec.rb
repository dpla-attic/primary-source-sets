require 'rails_helper'

describe SourceSet, type: :model do

  let(:source_set) { create(:source_set_factory) }
  let(:published_set) { create(:source_set_factory, published: true) }

  it 'has many sources' do
    expect(SourceSet.reflect_on_association(:sources).macro).to eq :has_many
  end

  it 'has many guides' do
    expect(SourceSet.reflect_on_association(:guides).macro).to eq :has_many
  end

  it 'has and belongs to many authors' do
    expect(SourceSet.reflect_on_association(:authors).macro)
      .to eq :has_and_belongs_to_many
  end

  it 'has and belongs to many tags' do
    expect(SourceSet.reflect_on_association(:tags).macro)
      .to eq :has_and_belongs_to_many
  end

  it 'has one featured source' do
    expect(SourceSet.reflect_on_association(:featured_source).macro)
      .to eq :has_one
  end

  it 'is invalid without name' do
    expect(SourceSet.new(name: nil)).not_to be_valid
  end

  it 'has a slug' do
    expect(SourceSet.create(name: 'Little My').slug).to eq 'little-my'
  end

  it 'validates numericality of year' do
    expect(SourceSet.create(name: 'Little My', year: 'abc')).not_to be_valid
  end

  it 'allows year to be nil' do
    expect(SourceSet.create(name: 'Little My', year: nil)).to be_valid
  end

  it 'validates year is less than or equal to current year' do
    next_year = Date.today.year + 1
    expect(SourceSet.create(name: 'Little My', year: next_year))
      .not_to be_valid
  end

  context 'with featured source' do

    let(:source) do
      create(:source_factory, featured: true)
    end

    let(:small_image) { create(:image_factory, size: 'small') }

    before(:each) do
      source_set.sources << source
      source.images << small_image
    end

    it 'recognizes featured source' do
      expect(source_set.featured_source).to eq source
    end

    it 'recognizes a featured image' do
      expect(source_set.featured_image).to eq small_image
    end
  end

  describe '#published_sets' do
    it 'returns published sets' do
      expect(SourceSet.published_sets).to contain_exactly(published_set)
    end
  end

  describe '#unpublished_sets' do
    it 'returns unpublished sets' do
      expect(SourceSet.unpublished_sets).to contain_exactly(source_set)
    end
  end
end
