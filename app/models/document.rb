class Document < ActiveRecord::Base
  has_many :attachments, as: :asset
  has_many :sources, through: :attachments
  validates :mime_type, presence: :true
  validates :file_base, presence: :true
end
