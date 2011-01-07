class ExtendUserTableForSponsor < ActiveRecord::Migration
  def self.up
    add_column :users, :sponsorship_payed, :boolean, :default => false
    add_column :users, :sponsorship_note, :text
  end

  def self.down
    remove_column :users, :sponsorship_payed
    remove_column :users, :sponsorship_note
  end
end
