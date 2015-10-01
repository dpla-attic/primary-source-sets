class SourcesFeaturedDefault < ActiveRecord::Migration
  def change
    change_column :sources, :featured, :boolean, default: :false
  end
end
