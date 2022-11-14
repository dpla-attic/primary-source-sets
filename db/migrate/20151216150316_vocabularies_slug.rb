class VocabulariesSlug < ActiveRecord::Migration[4.2]
  def change
    change_table :vocabularies do |t|
      t.string :slug, unique: true
    end
  end
end
