class Score < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  
  validates_numericality_of :goals, :only_integer => true
  validates_numericality_of :assists, :only_integer => true
  validates_presence_of :player_id
  validates_presence_of :game_id
  
  after_create :check_player_is_registered
  
  def check_player_is_registered
    unless game.players.include?(player)
      game.users << player.user
    end
  end
  
end