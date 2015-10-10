class AddFeaturedToSources < ActiveRecord::Migration
  def change
    change_table :sources do |t|
      t.boolean :featured
    end
  end
end
