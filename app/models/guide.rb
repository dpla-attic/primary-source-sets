class Guide < ActiveRecord::Base
  extend FriendlyId
  belongs_to :source_set
  has_and_belongs_to_many :authors
  validates :name, presence: true
  ##
  # FriendlyId generates a human-readable slug to be used in the URL, in place
  # of the ID.  The slug is automatically generated from the name field.
  #
  # Example:
  #   Guide.create({ name: "Little My" }).slug = "little-my"
  #   URL:  http://example.com/primary-source-sets/guides/little-my
  #   To find this object: Guide.friendly.find("little-my")
  friendly_id :name, use: :slugged
end
