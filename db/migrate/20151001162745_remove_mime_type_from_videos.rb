class RemoveMimeTypeFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :mime_type, :string
  end
end
