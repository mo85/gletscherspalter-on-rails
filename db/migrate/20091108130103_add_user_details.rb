class AddUserDetails < ActiveRecord::Migration
  def self.up
    add_column :users, :phone, :string
    add_column :users, :mobile, :string
    
    add_column :users, :street, :string
    add_column :users, :number, :string
    add_column :users, :city, :string
    add_column :users, :zip, :integer
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :mobile
    
    remove_column :users, :street
    remove_column :users, :number
    remove_column :users, :city
    remove_column :users, :zip
  end
end
