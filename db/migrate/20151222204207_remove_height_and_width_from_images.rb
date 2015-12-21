class RemoveHeightAndWidthFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :height, :integer
    remove_column :images, :width, :integer
  end
end
