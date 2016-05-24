class SourceSetsTag < ActiveRecord::Base
  belongs_to :source_set
  belongs_to :tag
  before_create :touch_source_set
  before_destroy :touch_source_set

  private

  def touch_source_set

  end
end
