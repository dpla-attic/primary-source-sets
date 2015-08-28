class SourceSetsPublishedDefault < ActiveRecord::Migration
  def change
    change_column :source_sets, :published, :boolean, default: :false
  end
end
