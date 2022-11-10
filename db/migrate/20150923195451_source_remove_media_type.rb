class SourceRemoveMediaType < ActiveRecord::Migration[4.2]
  def change
    remove_column :sources, :media_type
  end
end
