class Tag < ActiveRecord::Base
  extend FriendlyId
  has_and_belongs_to_many :source_sets
  has_many :tag_sequences, dependent: :destroy
  has_many :vocabularies, through: :tag_sequences
  validates :label, presence: true, uniqueness: true
  validates :uri, format: { with: URI.regexp }, if: proc { |a| a.uri.present? }

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
end
