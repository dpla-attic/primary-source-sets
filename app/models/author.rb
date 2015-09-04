class Author < ActiveRecord::Base
  has_and_belongs_to_many :source_sets
  has_and_belongs_to_many :guides
  validates :name, presence: true
end
