class SourceSetsPublishedDefault < ActiveRecord::Migration[4.2]
  def change
    change_column :source_sets, :published, :boolean, default: :false
  end
end
