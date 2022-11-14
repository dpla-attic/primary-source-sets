class SourcesCitationCreditsTextLimits < ActiveRecord::Migration[4.2]
  def change
    change_column :sources, :citation, :text, limit: 65535
    change_column :sources, :credits, :text, limit: 65535
  end
end
