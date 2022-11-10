class TagsSlug < ActiveRecord::Migration[4.2]
  def change
    change_table :tags do |t|
      t.string :slug, unique: true
    end
  end
end
