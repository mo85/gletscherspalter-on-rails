class RenameNewsModelToMessage < ActiveRecord::Migration
  def self.up
    rename_table(:news, :messages)
  end

  def self.down
    rename_table(:messages, :news)
  end
end
