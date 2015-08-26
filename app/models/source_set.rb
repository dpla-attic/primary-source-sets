class SourceSet < ActiveRecord::Base
  validates :name, presence: true
end
