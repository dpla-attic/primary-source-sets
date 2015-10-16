class Video < ActiveRecord::Base
  has_many :attachments, as: :asset, dependent: :destroy
  has_many :sources, through: :attachments
  validates :file_base, presence: :true
end
