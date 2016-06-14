class Tag < ActiveRecord::Base
  extend FriendlyId
  has_and_belongs_to_many :source_sets, after_add: :touch_source_set,
                                        before_remove: :touch_source_set
  has_many :tag_sequences, dependent: :destroy
  has_many :vocabularies, through: :tag_sequences,
                          after_add: :touch_self,
                          before_remove: :touch_self
  validates :label, presence: true, uniqueness: true
  validates :uri, format: { with: URI.regexp }, if: proc { |a| a.uri.present? }
  after_update :touch_associated_source_sets
  before_destroy :touch_associated_source_sets
  after_touch :touch_associated_source_sets

  ##
  # FriendlyId generates a human-readable slug to be used in the URL, in place
  # of the ID.  The slug is automatically generated from the name field.
  #
  # Example:
  #   Tag.create({ name: "Little My" }).slug = "little-my"
  #   URL:  http://example.com/primary-source-sets/tags/little-my
  #   To find this object: Tag.friendly.find("little-my")
  friendly_id :label, use: :slugged

  ##
  # Tags that belong to filterable vocabularies.
  # @see SourceSet.rb
  scope :filterable, (lambda do
                        joins(:vocabularies)
                          .where(vocabularies: { filter: true })
                      end)

  ##
  # @param Vocabulary
  # @return [ActiveRecord::Association<Tag>]
  def self.with_vocabulary(vocab)
    joins(:vocabularies).where(vocabularies: { id: vocab.id })
  end

  ##
  # Update the cache key of all tags associated with a given vocabulary.
  # Update the cache key of all source sets associated with the tags.
  # @param Vocabulary
  def self.touch_tags_with_vocab(vocab)
    # Note that update_all does not trigger ActiveRecord callbacks.
    with_vocabulary(vocab).update_all(updated_at: Time.now)
    SourceSet.touch_sets_with_tags(with_vocabulary(vocab))
  end

  private

  ##
  # Update cache keys of self and all associated source sets.
  # @param ActiveRecord
  def touch_self(record)
    return if self.new_record? # cannot touch unsaved record
    self.touch
  end

  ##
  # Update timestamp of a given source set.
  def touch_source_set(set)
    set.touch
  end

  ##
  # Update timestamps of all source sets associated with self.
  def touch_associated_source_sets
    SourceSet.touch_sets_with_tags(self)
  end
end
