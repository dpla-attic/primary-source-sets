class AddMetaToImages < ActiveRecord::Migration
  def change
    add_column :images, :meta, :text
  end
end
