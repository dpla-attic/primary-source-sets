class RemoveMimeTypeFromAudios < ActiveRecord::Migration
  def change
    remove_column :audios, :mime_type, :string
  end
end
