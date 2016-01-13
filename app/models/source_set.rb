class SourceSet < ActiveRecord::Base
  extend FriendlyId
  include Authored
  has_many :sources, dependent: :destroy
  has_many :guides, dependent: :destroy
  has_one :featured_source, -> { where featured: true }, class_name: 'Source'
  has_many :small_images, through: :featured_source
  has_and_belongs_to_many :tags
  validates :name, presence: true
  validates_numericality_of :year, only_integer: true, allow_nil: true,
                                   less_than_or_equal_to: Date.today.year

  ##
  # FriendlyId generates a human-readable slug to be used in the URL, in place
  # of the ID.  The slug is automatically generated from the name field.
  #
  # Example:
  #   SourceSet.create({ name: "Little My" }).slug = "little-my"
  #   URL:  http://example.com/primary-source-sets/sets/little-my
  #   To find this object: SourceSet.friendly.find("little-my")
  friendly_id :name, use: :slugged

  def featured_image
    small_images.first
  end

  def self.published_sets
    self.where(published: true)
  end

  def self.unpublished_sets
    self.where(published: false)
  end

  ##
  # Order SourceSets by a given parameter.
  # If a parameter is not included in the sort_params hash, it will be ignored.
  # By default, it will order by 'recently_added'.
  # @param order String or nil
  # @return ActiveRecord::Relation
  def self.order_by(order)
    sort_params = { 'recently_added' => { created_at: :desc },
                    'chronology_desc' => { year: :desc },
                    'chronology_asc' => { year: :asc } }
    order(sort_params[order] || sort_params['recently_added'])
  end

  ##
  # Get SourceSets associated with all of the specified tags.
  # EACH returned SourceSet will have ALL of the tags.
  # If no tags are specified, return all SourceSets.
  # @param tags [Array<String>] or nil
  # @return [Array<SourceSet>]
  def self.with_tags(tags)
    return all unless tags.present?
    tags.map { |tag| with_tag(tag) }.inject(:&).to_a
  end

  ##
  # Get SourceSets associated with the specified tag.
  # @param tag [String]
  # @return [SourceSet]
  def self.with_tag(tag)
    joins(:tags).where('tags.label = ?', tag)
  end
  private_class_method :with_tag
end
