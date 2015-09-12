class Video < ActiveRecord::Base
  belongs_to :source
  validates :mime_type, presence: :true
  validates :file_base, presence: :true
  validates :source_id, single_asset: :true
end
