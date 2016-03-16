class AddPositionToSequences < ActiveRecord::Migration
  def change
    add_column :sequences, :position, :integer
  end
end
