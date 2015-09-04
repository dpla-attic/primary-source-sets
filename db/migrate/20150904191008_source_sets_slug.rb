class SourceSetsSlug < ActiveRecord::Migration
  def change
    change_table :source_sets do |t|
      t.string :slug, unique: true
    end
  end
end
