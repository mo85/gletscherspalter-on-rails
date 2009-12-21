class DropUnneededTables < ActiveRecord::Migration
  def self.up
    drop_table :games
    drop_table :games_players
    drop_table :roles
    drop_table :user_roles
  end

  def self.down
  end
end
