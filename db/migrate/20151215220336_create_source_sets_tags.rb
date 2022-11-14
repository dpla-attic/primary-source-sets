class CreateSourceSetsTags < ActiveRecord::Migration[4.2]
  def change
    create_table :source_sets_tags do |t|
      t.belongs_to :source_set, index: true
      t.belongs_to :tag, index: true
    end
  end
end
