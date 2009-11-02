class RenameMessageFieldMessageToText < ActiveRecord::Migration
  def self.up
    rename_column(:messages, :message, :text)
  end

  def self.down
    rename_column(:messages, :text, :message)
  end
end
