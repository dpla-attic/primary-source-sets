class TagsSlug < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.string :slug, unique: true
    end
  end
end
