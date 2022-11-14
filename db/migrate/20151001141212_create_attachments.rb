class CreateAttachments < ActiveRecord::Migration[4.2]
  def change
    create_table :attachments do |t|
      t.belongs_to :source, index: true
      t.references :asset, polymorphic: true
    end
  end
end
