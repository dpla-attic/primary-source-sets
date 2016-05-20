class Vocabulary < ActiveRecord::Base
  extend FriendlyId
  has_many :tag_sequences, dependent: :destroy
  has_many :tags, through: :tag_sequences,
                  after_add: :touch_tag,
                  before_remove: :touch_tag
  validates :name, presence: true, uniqueness: true
  after_update :touch_associated_tags
  # prepend before_destroy so it is exectued before dependent: :destroy
  before_destroy :touch_associated_tags, prepend: true
  after_touch :touch_associated_tags

  ##
  # FriendlyId generates a human-readable slug to be used in the URL, in place
  # of the ID.  The slug is automatically generated from the name field.
  #
  # Example:
  #   Vocabulary.create({ name: "Little My" }).slug = "little-my"
  #   URL:  http://example.com/primary-source-sets/vocabularies/little-my
  #   To find this object: Vocabulary.friendly.find("little-my")
  friendly_id :name, use: :slugged

  def self.filterable
    where(filter: true)
  end

  private

  ##
  # Update cache keys of all associated tags.
  def touch_associated_tags
    Tag.touch_tags_with_vocab(self)
  end

  ##
  # Update cache key of a given tag.
  def touch_tag(tag)
    tag.touch
  end
end
