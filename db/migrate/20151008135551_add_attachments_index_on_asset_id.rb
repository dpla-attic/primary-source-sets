class AddAttachmentsIndexOnAssetId < ActiveRecord::Migration
  def change
    add_index :attachments, :asset_id
  end
end
