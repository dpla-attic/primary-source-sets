class AddConfirmableToAdmin < ActiveRecord::Migration
  def self.up
    add_column :admins, :confirmation_token, :string
    add_column :admins, :confirmed_at, :datetime
    add_column :admins, :confirmation_sent_at, :datetime
    add_column :admins, :unconfirmed_email, :string
    add_index :admins, :confirmation_token, :unique => true

    Admin.update_all({
      :confirmed_at => DateTime.now,
      :confirmation_sent_at => DateTime.now
    })
  end

  def self.down
    remove_column :admins,
                  [:confirmation_token, :confirmed_at, :confirmation_sent_at,
                   :unconfirmed_email]
  end
end
