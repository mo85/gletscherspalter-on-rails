class LinkPlayersToGames < ActiveRecord::Migration
  def self.up
    create_table :games_players, :id => false do |t|
      t.integer :game_id
      t.integer :player_id
    end
  end

  def self.down
    drop_table :games_players
  end
end
