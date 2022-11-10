class RemoveMimeTypeFromAudios < ActiveRecord::Migration[4.2]
  def change
    remove_column :audios, :mime_type, :string
  end
end
