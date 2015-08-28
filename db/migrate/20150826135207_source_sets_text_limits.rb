class SourceSetsTextLimits < ActiveRecord::Migration
  def change
    # Limit text size to TEXT type equivalent
    change_column :source_sets, :description, :text, limit: 65535
    change_column :source_sets, :overview, :text, limit: 65535
    change_column :source_sets, :resources, :text, limit: 65535
  end
end
