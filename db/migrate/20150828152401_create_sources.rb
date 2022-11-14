class CreateSources < ActiveRecord::Migration[4.2]
  def change
    create_table :sources do |t|
      t.belongs_to :source_set, index: true
      t.string :name
      t.string :aggregation
      t.string :media_type
      t.text :textual_content
      t.timestamps null: false
    end
  end
end
