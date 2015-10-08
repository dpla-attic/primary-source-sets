class AddMetaToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :meta, :text
  end
end
