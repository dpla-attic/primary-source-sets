class CreateImages < ActiveRecord::Migration[4.2]
  def change
    create_table :images do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.string :mime_type
      t.string :file_base
      t.string :size
      t.integer :height
      t.integer :width
      t.string :alt_text
      t.timestamps null: false
    end
  end
end
