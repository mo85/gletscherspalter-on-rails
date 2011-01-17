class CreateSponsorsTable < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :street
      t.string :number
      t.integer :zip
      t.string :city
      
      t.boolean :sponsorship_payed, :default => false
      t.text :sponsorship_note
    end
  end

  def self.down
    drop_table :sponsors
  end
end
