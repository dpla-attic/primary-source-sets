class AddAttachmentsCompoundIndex < ActiveRecord::Migration
  def change
    add_index :attachments, [:source_id, :asset_type, :asset_id]
  end
end
