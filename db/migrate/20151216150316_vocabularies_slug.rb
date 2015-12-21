class VocabulariesSlug < ActiveRecord::Migration
  def change
    change_table :vocabularies do |t|
      t.string :slug, unique: true
    end
  end
end
