class FixGuestBookEntries < ActiveRecord::Migration
  def self.up
    drop_table(:guest_book_entries)
    add_column :guestnotes, :note, :string
  end

  def self.down
    create_table(:guest_book_entries)
    remove_column :guestnotes, :note
  end
end
