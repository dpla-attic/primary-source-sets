class AddFilterToVocabulary < ActiveRecord::Migration[4.2]
  def change
    add_column :vocabularies, :filter, :boolean
  end
end
