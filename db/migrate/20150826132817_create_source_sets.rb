class CreateSourceSets < ActiveRecord::Migration
  def change
    create_table :source_sets do |t|
      t.string :name
      t.boolean :published
      t.text :description
      t.text :overview
      t.text :resources
      t.timestamps null: false
    end
  end
end
