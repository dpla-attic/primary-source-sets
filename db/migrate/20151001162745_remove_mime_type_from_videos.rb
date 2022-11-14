class RemoveMimeTypeFromVideos < ActiveRecord::Migration[4.2]
  def change
    remove_column :videos, :mime_type, :string
  end
end
