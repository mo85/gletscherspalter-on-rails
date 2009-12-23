require 'digest/sha1'

class Game < Event
  
  has_many :scores
  belongs_to :season
  
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
    last(:conditions => ["score != ?",""])
  end

  def result
    if !(score.nil?) && !(opponent_score.nil?) 
      @result ||= "#{score}:#{opponent_score}"
    else
      nil
    end
  end

  def self.next_game
    find(:first, :conditions => ["date > ?", Time.zone.now]) 
  end
  
  def self.future_games(options = {})
    result = []
    with_scope :find => options do
      result << find(:all, :conditions => ["date >= ?", Time.zone.now])
    end
    result.flatten
  end
  
  def self.passed_games(options = {})
    result = []
    with_scope :find => options do
      result << find(:all, :conditions => ["date <= ?", Time.zone.now])
    end
    result.flatten
  end
  
  def score_of_player(player)
    scores.select{|s| s.player_id == player.id}.first
  end
  
end
