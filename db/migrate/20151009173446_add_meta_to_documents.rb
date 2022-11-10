class AddMetaToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :meta, :text
  end
end
