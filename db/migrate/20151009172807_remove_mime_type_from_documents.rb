class RemoveMimeTypeFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :mime_type, :string
  end
end
