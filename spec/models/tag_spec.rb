require 'rails_helper'

describe Tag, type: :model do

  it 'has and belongs to many source sets' do
    expect(Tag.reflect_on_association(:source_sets).macro)
      .to eq :has_and_belongs_to_many
  end

  it 'has many tag sequences' do
    expect(Tag.reflect_on_association(:tag_sequences).macro).to eq :has_many
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

  describe 'cache dependencies' do
    let(:tag) { create(:tag_factory) }
    let(:set) { create(:source_set_factory) }
    let(:vocab) { create(:vocabulary_factory) }

    before(:each) do
      set.tags << tag
    end

    it 'updates cache keys of associated sets when updated' do
      expect{ tag.update_attribute(:label, 'new label') }
        .to change{ set.reload.cache_key }
    end

    it 'updates cache key of associated set when new association saved' do
      tag2 = create(:tag_factory, label: '2nd label')
      expect{ tag2.source_sets << set }.to change{ set.reload.cache_key }
    end

    it 'updates cache key of associated set when association deleted' do
      expect{ tag.source_sets.delete(set) }.to change{ set.reload.cache_key }
    end

    it 'updates cache keys of associated sets when tag deleted' do
      expect{ tag.destroy }.to change{ set.reload.cache_key }
    end

    it 'updates cache key when new vocab association saved' do
      expect{ tag.vocabularies << vocab }.to change{ tag.reload.cache_key }
    end

    it 'updates cache key when vocab association deleted' do
      tag.vocabularies << vocab
      expect{ tag.vocabularies.delete(vocab) }.to change{ tag.reload.cache_key }
    end
  end
end
