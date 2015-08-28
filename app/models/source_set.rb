class SourceSet < ActiveRecord::Base
  has_many :sources, dependent: :destroy
  has_many :guides, dependent: :destroy
  has_and_belongs_to_many :authors
  validates :name, presence: true
end
