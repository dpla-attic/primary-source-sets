class GuidesSlug < ActiveRecord::Migration
  def change
    change_table :guides do |t|
      t.string :slug, unique: true
    end
  end
end
