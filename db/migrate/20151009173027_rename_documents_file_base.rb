class RenameDocumentsFileBase < ActiveRecord::Migration[4.2]
  def change
    rename_column :documents, :file_base, :file_name
  end
end
