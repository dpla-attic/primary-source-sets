class CreateAudios < ActiveRecord::Migration[4.2]
  def change
    create_table :audios do |t|
      t.integer :source_id
      t.string :mime_type
      t.string :file_base
      t.timestamps null: false
    end
  end
end
