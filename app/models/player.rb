# encoding: utf-8 
class Player < ActiveRecord::Base
  
  has_many :scores, :dependent => :destroy
  belongs_to :user

  # validation stuff
  validates_numericality_of :number, :allow_nil => true
  validates_numericality_of :member_since, :only_integer => true, :allow_nil => true, 
                            :greater_than => 1950, :less_than_or_equal_to => (Time.zone.now.year + 1)
  validate :number_must_not_be_negative
  validates_presence_of :position
  validates_presence_of :user_id
  validate :valid_position  
  
  ::Positions = {:BW => 'Verteidiger', :G => 'Goalie', :FW => 'Stürmer'}
  
  def games
    user.games
  end
  
  def passed_games
    games.where("date <= ?", Time.zone.now)
  end
  
  def position_as_string
    ::Positions[self.position.to_sym]
  end
  
  def name
    user.full_name
  end

  def firstname
    user.firstname
  end

  def lastname
    user.lastname
  end
  
  def goals(season = nil)
    g = games_played(season)
    scores = collect_scores(g)
    points = scores.sum(&:goals)
  end
  
  def assists(season = nil)
    g = games_played(season)
    scores = collect_scores(g)
    ass = scores.sum(&:assists)
  end

  def points(season = nil)
    assists(season) + goals(season)
  end
  
  def points_per_game(season = nil)
    g = games_played(season)
    scores = collect_scores(g)
    if g.empty? || scores.empty?
      return 0
    else
      points = scores.sum{ |s| (s.goals || 0) + (s.assists || 0) }
    end
    (points.to_f / g.size).round(2)
  end
  
  def games_of_season(season = Season.current)
    games.where("season_id = ?", season.id)
  end
  
  def games_played(season = nil)
    g = []
    if season
      g = games_of_season(season).select{|g| g.result != nil}
    else
      g = games.select{|g| g.result != nil}
    end 
    g
  end
  
  def goal_against_average(season = nil)
    games = games_played(season)
    no_of_games = games.size
    goals_against = games.inject(0){ |sum, g| sum += g.opponent_score }
    
    if no_of_games == 0
      return 0
    end
    (goals_against.to_f / no_of_games).round(2)
  end
  
  def wins(season = nil)
    games_played(season).select{ |g| g.score > g.opponent_score }.size
  end
  
  def defeats(season = nil)
    games_played(season).select{ |g| g.score < g.opponent_score }.size
  end
  
  def tied_games(season = nil)
    games_played(season).select{ |g| g.score == g.opponent_score }.size
  end
  
  def goals_against(season = nil)
    games_played(season).inject(0){ |sum, g| sum += g.opponent_score }
  end

  def self.goalies
    Player.find_all_by_position('G')
  end

  def self.players
    where("position != ?", 'G')
  end

  def self.players_with_scores(season)
    players.select{|p| p.points(season) > 0}
  end
  
  protected
  
    def number_must_not_be_negative
      errors.add("Nummer", 'muss positiv sein') if number && number < 0
    end
    
    def valid_position
      if (position == "FW" || position == "BW" || position == "G")
      else 
        errors.add(:position, 'is invalid! Possibilities: Forwards - FW, Backs - BW, Goalies - G')
      end
    end 
    
  private
  
  def collect_scores(games)
    games.collect{ |g| g.score_of_player(self) }.compact
  end
  
end
