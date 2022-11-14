class PublishExistingSets < ActiveRecord::Migration[4.2]
  def self.up
    SourceSet.update_all(published: true)
  end
end
