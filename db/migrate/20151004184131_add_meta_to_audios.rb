class AddMetaToAudios < ActiveRecord::Migration[4.2]
  def change
    add_column :audios, :meta, :text
  end
end
