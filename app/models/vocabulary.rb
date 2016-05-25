class Vocabulary < ActiveRecord::Base
  extend FriendlyId
  before_save :touch_tags
  before_destroy :touch_tags # This must be declared before dependent: :destroy
                             # statements b/c dependent: :destroy is also
                             # implemented as a before_destroy callback.
  has_many :tag_sequences, dependent: :destroy
  has_many :tags, through: :tag_sequences,
                  after_add: :touch_tag,
                  before_remove: :touch_tag
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

  def touch_tag(tag)
    tag.touch
  end

  def touch_tags
    Tag.touch_tags_with_vocab(self)
  end
end
