class AddMetaToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :meta, :text
  end
end
