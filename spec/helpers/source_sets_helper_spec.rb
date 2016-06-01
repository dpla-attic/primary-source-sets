require 'rails_helper'

describe SourceSetsHelper, type: :helper do

  let(:source_set_a) { create(:source_set_factory, name: 'set a') }
  let(:source_set_b) { create(:source_set_factory, name: 'set b') }
  let(:vocab_a) { create(:vocabulary_factory, name: 'voc a', filter: true) }
  let(:vocab_b) { create(:vocabulary_factory, name: 'voc b', filter: true) }
  let(:vocab_c) { create(:vocabulary_factory, name: 'voc c', filter: false) }
  let(:tag_a) { create(:tag_factory, label: 'tag a') }
  let(:tag_b) { create(:tag_factory, label: 'tag b') }
  let(:tag_c) { create(:tag_factory, label: 'tag c') }
  let(:tag_d) { create(:tag_factory, label: 'tag d') }

  describe '#sort_options' do
    it 'returns an array' do
      expect(helper.sort_options).to be_a Array
    end
  end

  describe '#filters_for_sets' do

    before(:each) do
      vocab_a.tags << [tag_a, tag_b]
      vocab_b.tags << [tag_d]
      vocab_c.tags << [tag_a]
      source_set_a.tags << [tag_a, tag_c]
      source_set_b.tags << [tag_a]
    end

    context 'source_set not defined' do
      it 'returns an empty Hash' do
        expect(helper.filters_for_sets(nil)).to eq({})
      end
    end

    context 'source_set defined' do
      let(:source_sets) { [source_set_a, source_set_b] }

      it 'returns a Hash' do
        expect(helper.filters_for_sets(source_sets)).to be_a Hash
      end

      it 'returns filterable vocabs' do
        expect(helper.filters_for_sets(source_sets).keys)
          .to match [vocab_a, vocab_b]
      end

      it 'returns tags associated with filterable vocabs and source_sets' do
        expect(helper.filters_for_sets(source_sets).values.flatten)
          .to contain_exactly tag_a
      end

      it 'returns tags ordered by tag sequence position' do
        vocab_a.tags << tag_c
        # reverse tag sequence position of vocab_a tags
        tsa = tag_a.tag_sequences.where(vocabulary_id: vocab_a.id)
                   .where(tag_id: tag_a.id).first
        tsa.update_attribute(:position, 1)
        tsc = tag_c.tag_sequences.where(vocabulary_id: vocab_a.id)
                   .where(tag_id: tag_c.id).first
        tsc.update_attribute(:position, 0)
        expect(helper.filters_for_sets(source_sets)[vocab_a])
          .to match [tag_c, tag_a]
      end
    end
  end

  describe '#selected_slugs_in' do
    it 'returns slugs of given tags that are in params' do
      helper.stub(:params).and_return(tags: [tag_a.slug])
      expect(helper.selected_slugs_in([tag_a, tag_b])).to eq [tag_a.slug]
    end
  end

  describe '#selected_tags_in' do
    it 'returns those given tags that are in params' do
      helper.stub(:params).and_return(tags: [tag_a.slug])
      expect(helper.selected_tags_in([tag_a, tag_b])).to eq [tag_a]
    end
  end

  describe '#selected_slugs_not_in' do
    it 'returns slugs of given tags that are not in params' do
      assign(:tags, [tag_a, tag_b])
      expect(helper.selected_slugs_not_in([tag_a, tag_c])).to eq [tag_b.slug]
    end
  end

  describe '#tag_filter_options' do
    it 'returns an array of tag names and slugs' do
      tags = [tag_a]
      expect(helper.tag_filter_options(tags))
        .to include(['tag a', tag_a.slug])
    end
  end
end
