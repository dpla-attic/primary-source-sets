class RenameImagesFileBase < ActiveRecord::Migration
  def change
    rename_column :images, :file_base, :file_name
  end
end
