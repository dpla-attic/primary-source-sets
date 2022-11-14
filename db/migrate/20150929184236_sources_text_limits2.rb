class SourcesTextLimits2 < ActiveRecord::Migration[4.2]
  def change
    change_column :sources, :textual_content, :text, limit: 16777215
  end
end
