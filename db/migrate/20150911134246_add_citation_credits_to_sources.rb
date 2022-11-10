class AddCitationCreditsToSources < ActiveRecord::Migration[4.2]
  def change
    change_table :sources do |t|
      t.text :citation
      t.text :credits
    end
  end
end
