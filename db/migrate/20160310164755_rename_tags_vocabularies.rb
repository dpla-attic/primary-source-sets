class RenameTagsVocabularies < ActiveRecord::Migration[4.2]
  def self.up
    rename_table :tags_vocabularies, :sequences
  end

  def self.down
    rename_table :sequences, :tags_vocabularies
  end
end
