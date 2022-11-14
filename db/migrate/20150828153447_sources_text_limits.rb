class SourcesTextLimits < ActiveRecord::Migration[4.2]
  def change
    change_column :sources, :textual_content, :text, limit: 65535
  end
end
