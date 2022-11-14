class AddAttachmentsCompoundIndex < ActiveRecord::Migration[4.2]
  def change
    add_index :attachments, [:source_id, :asset_type, :asset_id]
  end
end
