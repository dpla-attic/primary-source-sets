class CreateGuides < ActiveRecord::Migration[4.2]
  def change
    create_table :guides do |t|
      t.belongs_to :source_set, index: true
      t.string :name
      t.text :questions
      t.text :activity
      t.timestamps null: false
    end
  end
end
