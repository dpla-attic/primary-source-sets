class Document < ActiveRecord::Base
  has_many :attachments, as: :asset
  has_many :sources, through: :attachments
  validates :file_name, presence: :true
end
