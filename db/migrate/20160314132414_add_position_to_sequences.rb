class AddPositionToSequences < ActiveRecord::Migration[4.2]
  def change
    add_column :sequences, :position, :integer
  end
end
