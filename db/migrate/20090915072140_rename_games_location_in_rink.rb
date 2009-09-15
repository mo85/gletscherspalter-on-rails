class RenameGamesLocationInRink < ActiveRecord::Migration
  def self.up
    rename_column :games, :location_id, :rink_id
  end

  def self.down
    rename_column :games, :rink_id, :location_id
  end
end
