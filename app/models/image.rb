class Image < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  validates :file_base, presence: :true
  validates :mime_type, presence: :true
  validates :height, numericality: { only_integer: true }
  validates :width, numericality: { only_integer: true }
  # Each attachable object can only have one image of any given size.
  validates :size, presence: :true,
                   uniqueness: { scope: [:attachable_id, :attachable_type],
                                 message: 'already exists for this object' }
  validates :attachable_id, single_asset: :true

  def source
    return attachable if attachable.is_a? Source
  end

  def source_set
    return attachable if attachable.is_a? SourceSet
  end
end
