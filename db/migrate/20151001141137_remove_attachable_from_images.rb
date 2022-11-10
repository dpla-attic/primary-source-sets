class RemoveAttachableFromImages < ActiveRecord::Migration[4.2]
  def change
    remove_column :images, :attachable_id
    remove_column :images, :attachable_type
  end
end
