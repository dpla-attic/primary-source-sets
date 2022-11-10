class RenameSequencesTable < ActiveRecord::Migration[4.2]
  def self.up
    rename_table :sequences, :tag_sequences
  end

  def self.down
    rename_table :tag_sequences, :sequences
  end
end
