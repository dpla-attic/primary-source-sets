class RenameImagesFileBase < ActiveRecord::Migration[4.2]
  def change
    rename_column :images, :file_base, :file_name
  end
end
