class GuidesSlug < ActiveRecord::Migration[4.2]
  def change
    change_table :guides do |t|
      t.string :slug, unique: true
    end
  end
end
