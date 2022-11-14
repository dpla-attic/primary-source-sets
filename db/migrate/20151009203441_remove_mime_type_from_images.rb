class RemoveMimeTypeFromImages < ActiveRecord::Migration[4.2]
  def change
    remove_column :images, :mime_type, :string
  end
end
