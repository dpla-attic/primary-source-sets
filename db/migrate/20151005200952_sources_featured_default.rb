class SourcesFeaturedDefault < ActiveRecord::Migration[4.2]
  def change
    change_column :sources, :featured, :boolean, default: :false
  end
end
