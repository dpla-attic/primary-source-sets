class AddAttachmentsIndexOnAssetId < ActiveRecord::Migration[4.2]
  def change
    add_index :attachments, :asset_id
  end
end
