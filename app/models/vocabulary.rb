class Vocabulary < ActiveRecord::Base
  extend FriendlyId
  
  ##
  # The following before_destroy statement must be declared before
  # dependent: :destroy of tag_sequences b/c dependent: :destroy is also
  # implemented as a before_destroy callback, and they are executed in the order
  # in which they are defined.
  before_destroy :chain_touch_associated_tags
  before_update :chain_touch_associated_tags
  has_many :tag_sequences, dependent: :destroy
  has_many :tags, through: :tag_sequences,
                  after_add: :chain_touch_tag,
                  before_remove: :chain_touch_tag
  validates :name, presence: true, uniqueness: true

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
  # Update timestamps of all associated tags.
  def chain_touch_associated_tags
    Tag.chain_touch_tags_with_vocab(self)
  end

  ##
  # Update timestamp of a given tag.
  def chain_touch_tag(tag)
    tag.chain_touch_self
  end
end
