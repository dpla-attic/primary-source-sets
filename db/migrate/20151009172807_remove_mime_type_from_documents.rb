class RemoveMimeTypeFromDocuments < ActiveRecord::Migration[4.2]
  def change
    remove_column :documents, :mime_type, :string
  end
end
