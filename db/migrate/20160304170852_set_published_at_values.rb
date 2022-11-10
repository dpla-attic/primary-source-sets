class SetPublishedAtValues < ActiveRecord::Migration[4.2]
  def self.up
    SourceSet.where('published = ?', true).update_all('published_at=created_at')
  end
end
