class SourcesCitationCreditsTextLimits < ActiveRecord::Migration
  def change
    change_column :sources, :citation, :text, limit: 65535
    change_column :sources, :credits, :text, limit: 65535
  end
end
