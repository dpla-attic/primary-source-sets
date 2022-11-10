class AddMetaToVideos < ActiveRecord::Migration[4.2]
  def change
    add_column :videos, :meta, :text
  end
end
