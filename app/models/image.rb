class Image < ActiveRecord::Base
  has_many :attachments, as: :asset, dependent: :destroy
  has_many :sources, through: :attachments
  validates :file_name, presence: :true
  validates :size, presence: :true
end
