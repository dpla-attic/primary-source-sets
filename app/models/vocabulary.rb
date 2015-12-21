class Vocabulary < ActiveRecord::Base
  extend FriendlyId
  has_and_belongs_to_many :tags
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
end
