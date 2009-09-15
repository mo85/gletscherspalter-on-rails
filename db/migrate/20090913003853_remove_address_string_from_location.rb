class RemoveAddressStringFromLocation < ActiveRecord::Migration
  def self.up
    remove_column :locations, :address
  end

  def self.down
    add_column :loctions, :address, :string
  end
end
