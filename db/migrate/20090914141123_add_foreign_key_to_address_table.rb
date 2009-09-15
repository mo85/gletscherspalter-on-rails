class AddForeignKeyToAddressTable < ActiveRecord::Migration
  def self.up
    add_column :addresses, :location_id, :integer
  end

  def self.down
    remove_column :addresses, :location_id
  end
end
