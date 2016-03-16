require 'rails_helper'

describe Sequence, type: :model do

  let!(:sequence0) { create(:sequence_factory, tag_id: 1, vocabulary_id: 1) }

  it 'belongs to a tag' do
    expect(Sequence.reflect_on_association(:tag).macro).to eq :belongs_to
  end

  it 'belongs to a vocabulary' do
    expect(Sequence.reflect_on_association(:vocabulary).macro).to eq :belongs_to
  end

  it 'orders by position' do
    sequence1 = create(:sequence_factory, tag_id: 2, vocabulary_id: 2,
                                          position: 1)
    expect(Sequence.all).to eq [sequence0, sequence1]
  end

  describe '#set_position' do

    it 'sets position for tag within existing vocabulary' do
      sequence = build(:sequence_factory, position: nil, tag_id: 2,
                                          vocabulary_id: 1)
      sequence.save
      expect(sequence.reload.position).to eq 1
    end

    it 'sets position for tag with new vocabulary' do
      sequence = build(:sequence_factory, position: nil, tag_id: 2,
                                          vocabulary_id: 2)
      sequence.save
      expect(sequence.reload.position).to eq 0
    end

    it 'makes no change if position is not nil' do
      sequence = build(:sequence_factory, position: 8, tag_id: 2,
                                          vocabulary_id: 1)
      sequence.save
      expect(sequence.reload.position).to eq 8
    end
  end

  describe '#amend_positions' do

    it 'resets positions within vocabulary' do
      sequence = create(:sequence_factory, tag_id: 2, vocabulary_id: 1)
      sequence0.destroy
      expect(sequence.reload.position).to eq 0
    end

    it 'does not reset positions from other vocabularies' do
      sequence1 = create(:sequence_factory, tag_id: 2, vocabulary_id: 2)
      sequence2 = create(:sequence_factory, tag_id: 3, vocabulary_id: 2)
      sequence0.destroy
      expect(sequence1.reload.position).to eq 0
      expect(sequence2.reload.position).to eq 1
    end
  end
end
