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

  def self.published
    where(published: true)
  end

  def self.unpublished
    where(published: false)
  end

  ##
  # Returns sets with at least two matching tags (not including self).
  # Results are ordered so that sets with the highest number of matching tags
  # appear first.
  #
  # @return [Array<SourceSet>]
  def related_sets
    sets = tags.map { |tag| [tag.source_sets] }.flatten - [self]
    sets_with_count = sets.each_with_object(Hash.new(0)) do |set, count|
      count[set] += 1
    end
    sets_with_count.delete_if { |_set, count| count < 2 }
    Hash[sets_with_count.sort_by { |set, count| count }.reverse].keys
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
  # @param tags [Array<Tag>] or nil.
  # @return [Array<SourceSet>]
  def self.with_tags(tags)
    return all unless tags.present?
    tags.map { |tag| with_tag(tag) }.inject(:&).to_a
  end

  ##
  # Get SourceSets associated with the specified tag.
  # @param tag [Tag]
  # @return [ActiveRecord::Relation<SourceSet>]
  def self.with_tag(tag)
    joins(:tags).where('tags.id = ?', tag.id)
  end
  private_class_method :with_tag
end
