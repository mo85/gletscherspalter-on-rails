class ChangeNoteToText < ActiveRecord::Migration
  def self.up
    change_column :guestnotes, :note, :text
  end

  def self.down
    change_column :guestnotes, :note, :string
  end
end
