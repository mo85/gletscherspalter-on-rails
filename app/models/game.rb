class Game < ActiveRecord::Base
  
  has_and_belongs_to_many :players
  has_many :scores
  belongs_to :rink
  belongs_to :season
  
  validates_presence_of :rink, :opponent
  validates_format_of :result, :with => /([0-9]):([0-9])/, :allow_blank => true
  
  def self.last_game
    @last_game ||= last(:conditions => ["score != ?",""])
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
    @next_game ||= find(:first, :conditions => ["date > ?", Time.now]) 
  end
  
  def self.future_games(options = {})
    result = []
    with_scope :find => options do
      result << find(:all, :conditions => ["date >= ?", Time.now])
    end
    result.flatten
  end
  
  def self.passed_games(options = {})
    result = []
    with_scope :find => options do
      result << find(:all, :conditions => ["date <= ?", Time.now])
    end
    result.flatten
  end
  
  def score_of_player(player)
    scores.select{|s| s.player_id == player.id}.first
  end
  
end
