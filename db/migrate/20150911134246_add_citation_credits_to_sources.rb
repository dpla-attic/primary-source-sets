class AddCitationCreditsToSources < ActiveRecord::Migration
  def change
    change_table :sources do |t|
      t.text :citation
      t.text :credits
    end
  end
end
