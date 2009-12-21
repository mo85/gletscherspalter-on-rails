require 'digest/sha1'

class Game < Event
  
  has_many :scores
  belongs_to :season
  
  validates_presence_of :opponent
  
  def name
    if opponent == "Training"
      return "Training"
    end
    "Gletscherspalter vs. #{opponent}"
  end
  
  def players
    users.collect(&:player)
  end
  
  def self.last_game
    last(:conditions => ["score != ?",""])
  end
  
  def date_formatted
    I18n.l(date, :format => :default)
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
  
  def valid_player?(player)
    result = false
    if player.nil?
      errors.add("Spieler", "wurde nicht gefunden!")
    else
      result = true
    end
    result
  end
  
  def ical_id
    "gletscherspalter-game##{Digest::SHA1.hexdigest(self.id.to_s)[0...10]}"
  end
  
end
