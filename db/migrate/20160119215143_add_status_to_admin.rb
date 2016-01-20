class AddStatusToAdmin < ActiveRecord::Migration
  def self.up
    add_column :admins, :status, :integer, default: 0
    Admin.update_all({status: 2})
  end

  def self.down
    remove_column :admins, :status
  end
end
