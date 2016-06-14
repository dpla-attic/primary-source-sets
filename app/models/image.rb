class Image < ActiveRecord::Base
  has_many :attachments, as: :asset, dependent: :destroy
  has_many :sources, through: :attachments,
                     after_add: :touch_source,
                     before_remove: :touch_source
  validates :file_name, presence: :true
  validates :size, presence: :true
  after_update :touch_associated_sources
  # prepend before_destroy so it is exectued before dependent: :destroy
  before_destroy :touch_associated_sources, prepend: true
  after_touch :touch_associated_sources

  private

  ##
  # Update cache keys of all associated sources.
  # Update cache keys of all sets associated with those sources.
  def touch_associated_sources
    Source.touch_sources_with_image(self)
  end

  ##
  # Update cache key of a given source.
  # Update cache key of all sets associated with that source.
  def touch_source(source)
    source.touch
  end
end
