class Attachment < ActiveRecord::Base
  belongs_to :source
  belongs_to :asset, polymorphic: true
end
