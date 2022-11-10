class AddPublishedAtToSourceSets < ActiveRecord::Migration[4.2]
  def change
    add_column :source_sets, :published_at, :datetime
  end
end
