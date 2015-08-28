class CreateSourceSetsAuthors < ActiveRecord::Migration
  def change
    create_table :authors_source_sets, id: false do |t|
      t.belongs_to :source_set, index: true
      t.belongs_to :author, index: true
    end
  end
end
