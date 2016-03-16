class Vocabulary < ActiveRecord::Base
  extend FriendlyId
  has_many :tag_sequences, dependent: :destroy
  has_many :tags, through: :tag_sequences
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
end
