class Season < ActiveRecord::Base

  has_many :games, :order => "Date ASC", :dependent => :destroy
  has_many :events, :order => "Date ASC", :dependent => :destroy
  
  validates_presence_of :start_year
  validates_presence_of :end_year
  validates_numericality_of :start_year
  validates_numericality_of :end_year
  
  validates_uniqueness_of :start_year
  validates_uniqueness_of :end_year
  
  SWITCHING_MONTH = 7 # Switch on July
  
  default_scope order("start_year DESC")
  
  def self.current(time = Time.zone.now)
    year = time.year
    next_year = year + 1
    
    @season = where("start_year = ? AND end_year = ?", year, next_year).first
    
    if !@season 
      if time.month >= SWITCHING_MONTH
        @season = Season.create(:start_year => year, :end_year => next_year)
      else
        @season = Season.find_by_start_year_and_end_year(year - 1, next_year - 1)
        if !@season
          @season = Season.create(:start_year => year, :end_year => next_year)
        end
      end 
    end
    @season
  end
  
  def to_s
    "#{start_year} / #{end_year}"
  end
  
  def games_played
    @games_played ||= games.where("score >= ? OR opponent_score >= ?", 0, 0)
  end
  
  def wins
    games_played.select{ |g| g.score > g.opponent_score }
  end

  def tied_games
    games_played.select{ |g| g.score == g.opponent_score }
  end
  
  def defeats
    games_played.select{ |g| g.score < g.opponent_score }
  end
  
  def scored_goals
    games_played.all.sum(&:score)
  end
  
  def goals_against
    games_played.all.sum(&:opponent_score)
  end
  
end
