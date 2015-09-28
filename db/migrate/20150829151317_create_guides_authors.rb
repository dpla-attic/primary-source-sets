class CreateGuidesAuthors < ActiveRecord::Migration
  def change
    create_table :authors_guides, id: false do |t|
      t.belongs_to :guide, index: true
      t.belongs_to :author, index: true
    end
  end
end
