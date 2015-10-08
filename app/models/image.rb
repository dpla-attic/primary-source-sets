class Image < ActiveRecord::Base
  has_many :attachments, as: :asset
  has_many :sources, through: :attachments
  validates :file_base, presence: :true
  validates :mime_type, presence: :true
  validates :height, numericality: { only_integer: true }
  validates :width, numericality: { only_integer: true }
  validates :size, presence: :true
end
