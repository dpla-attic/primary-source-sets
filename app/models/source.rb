class Source < ActiveRecord::Base
  belongs_to :source_set
  has_many :attachments

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

  ##
  # Gets all assets associated with source through attachments table.
  # @return Array<ActiveRecord::Base>
  def assets
    attachments.map(&:asset)
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
end
