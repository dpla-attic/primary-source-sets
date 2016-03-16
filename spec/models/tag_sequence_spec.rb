require 'rails_helper'

describe TagSequence, type: :model do

  let!(:tag_sequence0) { create(:tag_sequence_factory, tag_id: 1,
                                                       vocabulary_id: 1) }

  it 'belongs to a tag' do
    expect(TagSequence.reflect_on_association(:tag).macro).to eq :belongs_to
  end

  it 'belongs to a vocabulary' do
    expect(TagSequence.reflect_on_association(:vocabulary).macro)
      .to eq :belongs_to
  end

  it 'orders by position' do
    tag_sequence1 = create(:tag_sequence_factory, tag_id: 2, vocabulary_id: 2,
                                                  position: 1)
    expect(TagSequence.all).to eq [tag_sequence0, tag_sequence1]
  end

  describe '#set_position' do

    it 'sets position for tag within existing vocabulary' do
      tag_sequence = build(:tag_sequence_factory, position: nil, tag_id: 2,
                                                  vocabulary_id: 1)
      tag_sequence.save
      expect(tag_sequence.reload.position).to eq 1
    end

    it 'sets position for tag with new vocabulary' do
      tag_sequence = build(:tag_sequence_factory, position: nil, tag_id: 2,
                                                  vocabulary_id: 2)
      tag_sequence.save
      expect(tag_sequence.reload.position).to eq 0
    end

    it 'makes no change if position is not nil' do
      tag_sequence = build(:tag_sequence_factory, position: 8, tag_id: 2,
                                                  vocabulary_id: 1)
      tag_sequence.save
      expect(tag_sequence.reload.position).to eq 8
    end
  end

  describe '#amend_positions' do

    it 'resets positions within vocabulary' do
      tag_sequence = create(:tag_sequence_factory, tag_id: 2, vocabulary_id: 1)
      tag_sequence0.destroy
      expect(tag_sequence.reload.position).to eq 0
    end

    it 'does not reset positions from other vocabularies' do
      tag_sequence1 = create(:tag_sequence_factory, tag_id: 2, vocabulary_id: 2)
      tag_sequence2 = create(:tag_sequence_factory, tag_id: 3, vocabulary_id: 2)
      tag_sequence0.destroy
      expect(tag_sequence1.reload.position).to eq 0
      expect(tag_sequence2.reload.position).to eq 1
    end
  end
end
