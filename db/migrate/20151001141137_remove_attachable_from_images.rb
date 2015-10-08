class RemoveAttachableFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :attachable_id
    remove_column :images, :attachable_type
  end
end
