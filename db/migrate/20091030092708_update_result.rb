class UpdateResult < ActiveRecord::Migration
  def self.up
    remove_column(:games, :result)
    add_column(:games, :score, :integer)
    add_column(:games, :opponent_score, :integer)
  end

  def self.down
    add_column(:games, :result, :string)
    remove_column(:games, :score)
    remove_column(:games, :opponent_score)
  end
end
