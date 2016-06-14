require 'rails_helper'

describe SourceSet, type: :model do

  let(:source_set) { create(:source_set_factory) }
  let(:published_set) { create(:source_set_factory, published: true) }

  it_behaves_like 'authored' do
    let(:resource) { source_set }
  end

  it 'has many sources' do
    expect(SourceSet.reflect_on_association(:sources).macro).to eq :has_many
  end

  it 'has many guides' do
    expect(SourceSet.reflect_on_association(:guides).macro).to eq :has_many
  end

  it 'has and belongs to many tags' do
    expect(SourceSet.reflect_on_association(:tags).macro)
      .to eq :has_and_belongs_to_many
  end

  it 'has and belongs to many filter tags' do
    expect(SourceSet.reflect_on_association(:filter_tags).macro)
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

  describe '#published' do
    it 'returns published sets' do
      expect(SourceSet.published).to contain_exactly(published_set)
    end
  end

  describe '#unpublished' do
    it 'returns unpublished sets' do
      expect(SourceSet.unpublished).to contain_exactly(source_set)
    end
  end

  context 'with tags' do

    let(:a_tag) { create(:tag_factory, label: 'a') }
    let(:b_tag) { create(:tag_factory, label: 'b') }

    before(:each) do
      source_set.tags << a_tag
      published_set.tags << [a_tag, b_tag]
    end

    describe '#with_tags' do
      it 'returns source sets with all specified tags' do
        expect(SourceSet.with_tags([a_tag, b_tag]))
          .to contain_exactly(published_set)
      end

      it 'works in conjuction with published' do
        expect(SourceSet.published.with_tags([a_tag]))
          .to contain_exactly(published_set)
      end

      it 'returns all SourceSets if no tags specified' do
        expect(SourceSet.with_tags([])).to include(source_set, published_set)
      end
    end

    describe '#filter_tags' do
      it 'returns tags associated with filterable vocabularies' do
        a_tag.vocabularies << create(:vocabulary_factory, filter: true)
        expect(published_set.filter_tags).to contain_exactly a_tag
      end
    end
  end

  describe '#order_by' do

    let(:set_a) { create(:source_set_factory, year: 1920, published: true,
                         published_at: Time.new(2015)) }
    let(:set_b) { create(:source_set_factory, year: 1930, published: true,
                         published_at: Time.new(2016)) }

    before(:each) do
      set_a
      set_b
    end

    it 'orders by most recently published' do
      expect(SourceSet.order_by('recently_added')).to eq([set_b, set_a])
    end

    it 'orders by time period ascending' do
      expect(SourceSet.order_by('chronology_asc'))
        .to eq([set_a, set_b])
    end

    it 'orders by time period descending' do
      expect(SourceSet.order_by('chronology_desc'))
        .to eq([set_b, set_a])
    end

    it 'defaults to ordering by most recently published' do
      expect(SourceSet.order_by(nil)).to eq([set_b, set_a])
    end

    it 'ignores unexpected params' do
      expect(SourceSet.order_by('*****')).to eq([set_b, set_a])
    end
  end

  describe '#related_sets' do
    let(:a_tag) { create(:tag_factory, label: 'a') }
    let(:b_tag) { create(:tag_factory, label: 'b') }
    let(:c_tag) { create(:tag_factory, label: 'c') }

    let(:set_1) { create(:source_set_factory, published: true) }
    let(:set_2) { create(:source_set_factory, published: true) }
    let(:set_3) { create(:source_set_factory, published: true) }
    let(:set_4) { create(:source_set_factory, published: true) }

    before do
      set_1.tags << [a_tag, b_tag, c_tag]
      set_2.tags << [a_tag, b_tag]
      set_3.tags << [a_tag, b_tag, c_tag]
      set_4.tags << [a_tag]
    end

    it 'returns an Array' do
      expect(set_1.related_sets).to be_a(Array)
    end

    it 'returns published sets with at least two matching tags' do
      expect(set_1.related_sets).to contain_exactly(set_2, set_3)
    end

    it 'orders sets by number of matching tags' do
      expect(set_1.related_sets.first).to eq(set_3)
    end

    it 'does not return unpublished sets' do
      set_2.published = false
      set_2.save
      set_2.reload
      expect(set_1.related_sets).not_to include(set_2)
    end
  end

  describe '#check_publish_date' do
    it 'persists publication time when a set is published' do
      source_set.published = true
      source_set.save
      expect(source_set.reload.published_at).not_to be nil
    end

    it 'nulls the publication time when a set is unpublished' do
      published_set.published = false
      published_set.save
      expect(published_set.reload.published_at).to be nil
    end

    it 'does not change the publication time when a published set is edited' do
      time = Time.new(2015)
      set = create(:source_set_factory, published: true, published_at: time)
      set.name = "New name"
      set.save
      expect(set.reload.published_at).to eq time
    end
  end

  describe 'cache dependencies' do
    let(:tag) { create(:tag_factory) }
    let(:set) { create(:source_set_factory) }

    it 'changes cache key when new tag association saved' do
      expect{ set.tags << tag }.to change{ set.reload.cache_key }
    end

    it 'changes cache key when tag association deleted' do
      set.tags << tag
      expect{ set.tags.delete(tag) }.to change{ set.reload.cache_key }
    end
  end
end
