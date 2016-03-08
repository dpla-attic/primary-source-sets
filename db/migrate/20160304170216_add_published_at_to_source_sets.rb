class AddPublishedAtToSourceSets < ActiveRecord::Migration
  def change
    add_column :source_sets, :published_at, :datetime
  end
end
