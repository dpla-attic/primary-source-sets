class CreateGuidesAuthors < ActiveRecord::Migration[4.2]
  def change
    create_table :authors_guides, id: false do |t|
      t.belongs_to :guide, index: true
      t.belongs_to :author, index: true
    end
  end
end
