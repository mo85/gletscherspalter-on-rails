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
    team_name = APP_CONFIG["team"]["name"]
    result = "#{team_name} vs. #{opponent}"
    if season_id != 1
      unless home
        result = "#{opponent} vs. #{team_name}"
      end
    end
    result
  end
  
  def players
    users.collect(&:player)
  end
  
  def self.last_game
    where("score >= ? OR opponent_score >= ?", 0, 0).order("date").last
  end

  def result
    r = nil
    if !(score.blank?) && !(opponent_score.blank?)
      r = "#{score}:#{opponent_score}"
      if season_id != 1 && !home
        r = "#{opponent_score}:#{score}"
      end
    end
    r
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
