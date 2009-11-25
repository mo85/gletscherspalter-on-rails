class RenameGuestBook < ActiveRecord::Migration
  def self.up
    rename_table :guestbooks, :guestnotes
  end

  def self.down
    rename_table :guestnotes, :guestbooks
  end
end
