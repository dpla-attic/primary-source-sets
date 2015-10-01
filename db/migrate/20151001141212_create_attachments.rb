class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :source, index: true
      t.references :asset, polymorphic: true
    end
  end
end
