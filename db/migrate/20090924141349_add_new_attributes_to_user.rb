class AddNewAttributesToUser < ActiveRecord::Migration
  def self.up
    add_column(:users, :login, :string)
    add_column(:users, :firstname, :string)
    add_column(:users, :lastname, :string)
    add_column(:users, :is_admin, :boolean, :default => false)
  end

  def self.down
    remove_colums(:users, :login, :firstname, :lastname, :login)
  end
end
