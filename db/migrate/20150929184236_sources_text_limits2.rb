class SourcesTextLimits2 < ActiveRecord::Migration
  def change
    change_column :sources, :textual_content, :text, limit: 16777215
  end
end
