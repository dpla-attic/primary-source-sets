class Source < ActiveRecord::Base
  belongs_to :source_set
  has_many :images, as: :attachable, dependent: :destroy
  has_one :document, dependent: :destroy
  has_one :audio, dependent: :destroy
  has_one :video, dependent: :destroy

  has_one :large_image, -> { where size: 'large' }, as: :attachable,
                        class_name: 'Image'

  has_one :thumbnail, -> { where size: 'thumbnail' }, as: :attachable,
                      class_name: 'Image'

  validates :aggregation, presence: true

  def asset
    return large_image if large_image.present?
    return document if document.present?
    return audio if audio.present?
    return video if video.present?
  end

  def aggregation_uri
    Settings.frontend.url + 'item/' + aggregation
  end
end
