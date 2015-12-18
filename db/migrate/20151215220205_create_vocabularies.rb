class CreateVocabularies < ActiveRecord::Migration
  def change
    create_table :vocabularies do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
