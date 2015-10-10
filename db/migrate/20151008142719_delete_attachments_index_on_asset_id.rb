class DeleteAttachmentsIndexOnAssetId < ActiveRecord::Migration
  def change
    remove_index :attachments, name: 'index_attachments_on_asset_id'
  end
end
