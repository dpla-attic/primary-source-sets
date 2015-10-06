class Audio < ActiveRecord::Base
  belongs_to :source
  validates :file_base, presence: :true
  validates :source_id, single_asset: :true
end
