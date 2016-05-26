class Image < ActiveRecord::Base
  ##
  # The following before_destroy statement must be declared before
  # dependent: :destroy on attachments b/c dependent: :destroy is also
  # implemented as a before_destroy callback, and they are executed in the order
  # in which they are defined.
  before_destroy :chain_touch_associated_sources
  before_update :chain_touch_associated_sources
  has_many :attachments, as: :asset, dependent: :destroy
  has_many :sources, through: :attachments,
                     after_add: :chain_touch_source,
                     before_remove: :chain_touch_source
  validates :file_name, presence: :true
  validates :size, presence: :true

  private

  ##
  # Update timestamps of all associated sources.
  # Update timestamps of all sets associated with those sources.
  def chain_touch_associated_sources
    Source.chain_touch_sources_with_image(self)
  end

  ##
  # Update timestamp of a given source.
  # Update timestamp of all sets associated with that source.
  def chain_touch_source(source)
    source.chain_touch_self
  end
end
