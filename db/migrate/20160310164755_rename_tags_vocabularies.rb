class RenameTagsVocabularies < ActiveRecord::Migration
  def self.up
    rename_table :tags_vocabularies, :sequences
  end

  def self.down
    rename_table :sequences, :tags_vocabularies
  end
end
