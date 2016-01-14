class AddFilterToVocabulary < ActiveRecord::Migration
  def change
    add_column :vocabularies, :filter, :boolean
  end
end
