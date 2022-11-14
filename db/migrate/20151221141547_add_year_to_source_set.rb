class AddYearToSourceSet < ActiveRecord::Migration[4.2]
  def change
    add_column :source_sets, :year, :integer
  end
end
