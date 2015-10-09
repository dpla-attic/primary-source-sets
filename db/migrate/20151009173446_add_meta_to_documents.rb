class AddMetaToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :meta, :text
  end
end
