class SourceSet < ActiveRecord::Base
  extend FriendlyId
  include Authored
  has_many :sources, dependent: :destroy
  has_many :guides, dependent: :destroy
  has_one :featured_source, -> { where featured: true }, class_name: 'Source'
  has_many :small_images, through: :featured_source
  has_and_belongs_to_many :tags, after_add: :when_i_think_about,
                                 before_remove: :when_i_think_about
  has_and_belongs_to_many :filter_tags, -> { filterable }, class_name: 'Tag'
  validates :name, presence: true
  validates_numericality_of :year, only_integer: true, allow_nil: true,
                                   less_than_or_equal_to: Date.today.year
  before_save :check_publish_date

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
  # Returns published sets with at least two matching tags (not including self).
  # Results are ordered so that sets with the highest number of matching tags
  # appear first.
  #
  # @return [Array<SourceSet>]
  def related_sets
    sets = SourceSet.published
                    .joins(:tags)
                    .where(tags: { id: tags.ids })
                    .where.not(id: self.id)
                    .includes(:small_images)

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
    sort_params = { 'recently_added' => { published_at: :desc },
                    'chronology_desc' => { year: :desc },
                    'chronology_asc' => { year: :asc } }
    order(sort_params[order] || sort_params['recently_added'])
  end

  ##
  # Get SourceSets associated with all of the specified tags.
  # EACH returned SourceSet will have ALL of the tags.
  # If no tags are specified, return all SourceSets.
  # @param tags [Array<Tag>] or nil.
  # @return [ActiveRecord::Relation<SourceSet>]
  def self.with_tags(tags)
    return all unless tags.present?
    tag_ids = tags.map { |tag| tag.id }
    joins(:tags).where(tags: { id: tag_ids })
                .having('count(tags.id) = ?', tag_ids.count)
                .group('source_sets.id')
  end

  ##
  # Update the timestamp of all source sets associated with any of a given tag
  # or group of tags. If a source set is associated with at least one on the
  # given tags, it will be updated.
  # This will in turn update the source set's cache key.
  # @param tags Tag OR [ActiveRecord::Relation<Tag>]
  def self.touch_sets_with_tags(tags)
    ids = tags.class.name == 'Tag' ? tags.id : tags.ids
    joins(:tags).where(tags: { id: ids }).update_all(updated_at: Time.now)
  end

  ##
  # If the set is being published, save the current timestamp.
  # If the set was already published, do not save the current timestamp.
  # If the set is unpublished, clear the timestamp.
  def check_publish_date
    if self.published == true && self.published_at == nil
      self.published_at = Time.now
    elsif self.published == false
      self.published_at = nil
    end
  end

  private

  def when_i_think_about(you)
    self.touch
  end
end
