class Audio < ActiveRecord::Base
  has_many :attachments, as: :asset
  has_many :sources, through: :attachments
  validates :file_base, presence: :true
end
