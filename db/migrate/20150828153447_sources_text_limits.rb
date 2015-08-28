class SourcesTextLimits < ActiveRecord::Migration
  def change
    change_column :sources, :textual_content, :text, limit: 65535
  end
end
