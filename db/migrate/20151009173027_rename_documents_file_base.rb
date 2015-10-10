class RenameDocumentsFileBase < ActiveRecord::Migration
  def change
    rename_column :documents, :file_base, :file_name
  end
end
