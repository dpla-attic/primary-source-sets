class CreateTagsVocabularies < ActiveRecord::Migration
  def change
    create_table :tags_vocabularies do |t|
      t.belongs_to :vocabulary, index: true
      t.belongs_to :tag, index: true
    end
  end
end
