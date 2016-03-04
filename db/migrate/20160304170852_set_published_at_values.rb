class SetPublishedAtValues < ActiveRecord::Migration
  def self.up
    SourceSet.where('published = ?', true).update_all('published_at=created_at')
  end
end
