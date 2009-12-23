include ActionView::Helpers::UrlHelper

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
    games.select{ |g| g.date <= Time.zone.now }
  end
  
  def position_as_string
    ::Positions[self.position.to_sym]
  end
  
  def name
    user.full_name
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
    games.select{ |g| g.season == season }
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
  
  def games_to_ical(host)
    cal = Icalendar::Calendar.new 
    games_of_season.each do |game|
      game_url = game_link(host, game)
      cal.event do
        dtstart       game.date.strftime("%Y%m%dT%H%M%S")
        dtend         2.hours.since(game.date).strftime("%Y%m%dT%H%M%S")
        summary       "#{game.name}"
        location      game.location.name
        uid           game.ical_id
        url           game_url
      end
    end
    cal.to_ical
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
  
  def game_link(host, game)
    helpers.link_to(game.name, url_for(:host => host, :controller => "games", :action => "show", :id => game.to_param))
  end
  
end
