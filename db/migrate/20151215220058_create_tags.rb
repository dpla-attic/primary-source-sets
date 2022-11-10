class CreateTags < ActiveRecord::Migration[4.2]
  def change
    create_table :tags do |t|
      t.string :label
      t.string :uri
      t.timestamps null: false
    end
  end
end
