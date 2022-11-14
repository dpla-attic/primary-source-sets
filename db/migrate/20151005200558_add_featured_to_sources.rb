class AddFeaturedToSources < ActiveRecord::Migration[4.2]
  def change
    change_table :sources do |t|
      t.boolean :featured
    end
  end
end
