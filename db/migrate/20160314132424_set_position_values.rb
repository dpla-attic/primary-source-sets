class SetPositionValues < ActiveRecord::Migration[4.2]
  def self.up
    ##
    # Set initial position values for TagVocabulary.
    # Each tag's poisiton within its associated vocabulaires is set based on
    # its created_at date. This will preserve the current production order.
    Vocabulary.all.each do |vocab|
      vocab.tags.order(created_at: :asc).each_with_index do |tag, index|
        s = Sequence.where(tag_id: tag.id).where(vocabulary_id: vocab.id).first
        s.position = index
        s.save
      end
    end
  end

  def self.down
    Sequence.update_all(position: nil)
  end
end
