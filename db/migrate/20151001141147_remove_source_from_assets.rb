class RemoveSourceFromAssets < ActiveRecord::Migration[4.2]
  def change
    remove_column :documents, :source_id
    remove_column :videos, :source_id
    remove_column :audios, :source_id
  end
end
