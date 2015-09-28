class GuidesTextLimits < ActiveRecord::Migration
  def change
    change_column :guides, :questions, :text, limit: 65535
    change_column :guides, :activity, :text, limit: 65535
  end
end
