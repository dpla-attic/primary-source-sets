class Guide < ActiveRecord::Base
  belongs_to :source_set
  has_and_belongs_to_many :authors
  validates :name, presence: true
end
