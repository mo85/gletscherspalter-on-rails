require 'digest/sha1'

class Game < Event
  has_and_belongs_to_many :users, :join_table =>"events_users", :foreign_key => "event_id"
  has_many :scores
  belongs_to :season
  belongs_to :rink, :foreign_key => "location_id"

  validates_presence_of :opponent, :location_id
  validates_numericality_of :score, :only_integer => true, :allow_nil => true
  validates_numericality_of :opponent_score, :only_integer => true, :allow_nil => true
  
  def locality
    location.name
  end
  
  def name
    "Gletscherspalter vs. #{opponent}"
  end
  
  def players
    users.collect(&:player)
  end
  
  def self.last_game
    where("score != ?","").last
  end

  def result
    if !(score.nil?) && !(opponent_score.nil?) 
      @result ||= "#{score}:#{opponent_score}"
    else
      nil
    end
  end

  def self.next_game
    where("date > ?", Time.zone.now).order("date ASC").first
  end
  
  def self.future_games(options = {})
    result = []
    with_scope :find => options do
      result << where("date >= ?", Time.zone.now)
    end
    result.flatten
  end
  
  def self.passed_games(options = {})
    result = []
    with_scope :find => options do
      result << where("date <= ?", Time.zone.now)
    end
    result.flatten
  end
  
  def score_of_player(player)
    scores.select{|s| s.player_id == player.id}.first
  end
  
end
