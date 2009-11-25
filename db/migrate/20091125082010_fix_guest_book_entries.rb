class FixGuestBookEntries < ActiveRecord::Migration
  def self.up
    add_column :guestnotes, :note, :string
  end

  def self.down
    remove_column :guestnotes, :note
  end
end
