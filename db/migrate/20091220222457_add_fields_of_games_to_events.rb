class AddFieldsOfGamesToEvents < ActiveRecord::Migration
  def self.up
    rename_column :games, :rink_id, :location_id
    
    add_column :events, :opponent, :string
    add_column :events, :score, :integer
    add_column :events, :opponent_score, :integer
    add_column :events, :season_id, :integer
    
    change_column :events, :location, :integer
    rename_column :events, :location, :location_id
  end

  def self.down
    rename_column :games, :location_id, :rink_id
    
    remove_column :events, :opponent
    remove_column :events, :score
    remove_column :events, :opponent_score
    remove_column :events, :season_id
    
    rename_column :events, :location_id, :location
    change_column :events, :location, :string
  end
end
