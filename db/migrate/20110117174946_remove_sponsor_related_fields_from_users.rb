class RemoveSponsorRelatedFieldsFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :sponsorship_payed
    remove_column :users, :sponsorship_note
    remove_column :users, :type
  end

  def self.down
    add_column :users, :sponsorship_payed, :boolean, :default => false
    add_column :users, :sponsorship_note, :text
    add_column :users, :type, :string
  end
end
