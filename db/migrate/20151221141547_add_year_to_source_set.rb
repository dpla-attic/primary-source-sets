class AddYearToSourceSet < ActiveRecord::Migration
  def change
    add_column :source_sets, :year, :integer
  end
end
