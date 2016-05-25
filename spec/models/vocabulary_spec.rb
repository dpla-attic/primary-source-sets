require 'rails_helper'

describe Vocabulary, type: :model do

  it 'has many tag sequences' do
    expect(Vocabulary.reflect_on_association(:tag_sequences).macro)
      .to eq :has_many
  end

  it 'has many tags' do
    expect(Vocabulary.reflect_on_association(:tags).macro).to eq :has_many
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

  it 'dependent destroys tag sequences' do
    vocab = create(:vocabulary_factory)
    vocab.tags << create(:tag_factory)
    expect{ vocab.destroy }.to change{ TagSequence.count }.by -1
  end

  context 'with filterable vocabs' do
    let(:filterable) { create(:vocabulary_factory, filter: true) }

    let(:unfilterable) do 
      create(:vocabulary_factory,
      filter: false,
      name: 'another name')
    end

    let(:tag) { create(:tag_factory) }

    before(:each) do
      filterable.tags << tag
      unfilterable
    end

    describe '#filterable' do
      it 'returns vocubularies where filter is true' do
        expect(Vocabulary.filterable).to contain_exactly(filterable)
      end
    end
  end

  describe 'cache dependencies' do
    let(:vocab) { create(:vocabulary_factory) }
    let(:tag) { create(:tag_factory) }
    let(:source_set) { create(:source_set_factory) }

    before(:each) do
      vocab.tags << tag
      source_set.tags << tag
    end

    it 'updates cache keys of associated tags when updated' do
      expect{ vocab.update_attribute(:name, 'new name') }
        .to change{ tag.reload.cache_key }
    end

    it 'updates cache keys of source sets of associated tags when updated' do
      expect{ vocab.update_attribute(:filter, true) }
        .to change{ source_set.reload.cache_key }
    end

    it 'updates cache key of associated tag when new association saved' do
      vocab2 = create(:vocabulary_factory, name: '2nd name')
      expect{ tag.vocabularies << vocab2 }.to change{ tag.reload.cache_key }
    end

    it 'updates cache key of associated tag when association deleted' do
      expect{ tag.vocabularies.delete(vocab) }.to change{ tag.reload.cache_key }
    end

    it 'updates cache keys of associated tags when vocab deleted' do
      expect{ vocab.destroy }.to change{ tag.reload.cache_key }
    end
  end
end
