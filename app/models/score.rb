class Score < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  
  validates_numericality_of :goals, :only_integer => true
  validates_numericality_of :assists, :only_integer => true
  validates_presence_of :player_id
  validates_presence_of :game_id

end