class SourceSet < ActiveRecord::Base
  extend FriendlyId
  has_many :sources, dependent: :destroy
  has_many :guides, dependent: :destroy
  has_and_belongs_to_many :authors
  has_many :images, as: :attachable, dependent: :destroy

  has_one :large_image, -> { where size: 'large' }, as: :attachable,
                        class_name: 'Image'

  has_one :thumbnail, -> { where size: 'thumbnail' }, as: :attachable,
                      class_name: 'Image'

  validates :name, presence: true

  ##
  # FriendlyId generates a human-readable slug to be used in the URL, in place
  # of the ID.  The slug is automatically generated from the name field.
  #
  # Example:
  #   SourceSet.create({ name: "Little My" }).slug = "little-my"
  #   URL:  http://example.com/primary-source-sets/sets/little-my
  #   To find this object: SourceSet.friendly.find("little-my")
  friendly_id :name, use: :slugged
end
