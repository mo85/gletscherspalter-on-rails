class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      
      t.string :city
      t.integer :zip
      
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
