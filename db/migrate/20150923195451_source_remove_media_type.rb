class SourceRemoveMediaType < ActiveRecord::Migration
  def change
    remove_column :sources, :media_type
  end
end
