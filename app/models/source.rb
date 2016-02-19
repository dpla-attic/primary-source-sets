class Source < ActiveRecord::Base
  belongs_to :source_set
  has_many :attachments, dependent: :destroy

  has_many :videos, through: :attachments,
                    source: :asset,
                    source_type: 'Video'

  has_many :audios, through: :attachments,
                    source: :asset,
                    source_type: 'Audio'

  has_many :documents, through: :attachments,
                       source: :asset,
                       source_type: 'Document'

  has_many :images, through: :attachments,
                    source: :asset,
                    source_type: 'Image'

  has_many :large_images, -> { where size: 'large' },
                          through: :attachments,
                          source: :asset,
                          source_type: 'Image'

  has_many :small_images, -> { where size: 'small' },
                          through: :attachments,
                          source: :asset,
                          source_type: 'Image'

  has_many :thumbnails, -> { where size: 'thumbnail' },
                        through: :attachments,
                        source: :asset,
                        source_type: 'Image'

  validates :aggregation, presence: true

  default_scope { order('created_at ASC') }

  ##
  # Gets all assets associated with source through attachments table.
  # @return Array<ActiveRecord::Base>
  def assets
    attachments.map(&:asset).reject{ |a| a.nil? }
  end

  ##
  # Gets the first audio, video, document, or large image associated with the
  # source.
  # @return <ActiveRecord::Base>
  def main_asset
    assets.delete_if do |a|
      true if a.class.name == 'Image' && a.size != 'large'
    end.first
  end

  def thumbnail
    thumbnails.first
  end

  def small_image
    small_images.first
  end

  def display_name
    name.present? ? name : aggregation
  end

  ##
  # Get all other sources associated with this source's source_set.
  # The source that would appear after the current source in a default database
  # query is first in the return array.
  #
  # @example:
  #   <Source id: 3>.related_sources =>
  #      [<Source id: 4>, <Source id: 1>, <Source id: 2>]
  #
  # @return [Array<Source>]
  def related_sources
    source_set.sources.split { |s| s.id == id }.reverse.flatten
  end
end
