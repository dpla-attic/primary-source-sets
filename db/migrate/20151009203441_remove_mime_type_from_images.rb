class RemoveMimeTypeFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :mime_type, :string
  end
end
