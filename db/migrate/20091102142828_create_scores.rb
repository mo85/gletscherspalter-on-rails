class CreateScores < ActiveRecord::Migration
  def self.up
    create_table(:scores) do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :goals
      t.integer :assists
    end
  end

  def self.down
    drop_table(:scores)
  end
end
