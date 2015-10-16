class Image < ActiveRecord::Base
  has_many :attachments, as: :asset, dependent: :destroy
  has_many :sources, through: :attachments
  validates :file_name, presence: :true
  validates :height, numericality: { only_integer: true }, allow_blank: true
  validates :width, numericality: { only_integer: true }, allow_blank: true
  validates :size, presence: :true
end
