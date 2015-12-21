class PublishExistingSets < ActiveRecord::Migration
  def self.up
    SourceSet.update_all(published: true)
  end
end
