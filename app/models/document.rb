class Document < ActiveRecord::Base
  has_many :attachments, as: :asset, dependent: :destroy
  has_many :sources, through: :attachments
  validates :file_name, presence: :true
end
