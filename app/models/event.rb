class Event < ActiveRecord::Base
  acts_as_commentable

  belongs_to :location
  belongs_to :season
  
  has_many :resource_settings, :as => :resource
  
  has_and_belongs_to_many :users
  
  
  validates_presence_of :date, :season_id
  validate :end_date_is_after_start_date
  
  def players
    users.collect(&:player)
  end
  
  def date_formatted
    I18n.l(start_time, :format => :default)
  end
  
  def end_date_formatted
    I18n.l(end_time, :format => :default)    
  end

  def self.future_non_game_events(options = {})
    result = []
    with_scope :find => options do
      result << where("date > ? AND type != ?", Time.zone.now, "Game")
    end
    result.flatten
  end
  
  def self.find_all_non_game_events
    where("type != ?", "Game")
  end

  def self.next_non_game_event
    where("type != ? AND date > ?", "Game", Time.zone.now).order("date ASC").first
  end
  
  def name
    title
  end
  
  def controller_name
    self.class.to_s.downcase.pluralize
  end
  
  def self.future_events(tolerance = 0.seconds, options = {})
    result = []
    with_scope :find => options do
      result << where("date > ?", Time.zone.now + tolerance).order("date ASC")
    end
    result.flatten
  end
  
  def self.passed_events
    where("date < ?", Time.zone.now)
  end
  
  def result
    "-"
  end
  
  def self.games
    where("type = ?", "Game")
  end
  
  def group_players_by_position
    players.group_by(&:position)
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
    "gletscherspalter-event##{Digest::SHA1.hexdigest(self.id.to_s)[0...10]}"
  end
  
  def start_time
    date
  end
  
  def end_time
    event_end = end_date || 2.hours.since(date)
  end
  
  private
  
  def end_date_is_after_start_date
    if end_date
      errors.add_to_base("Das Ende des Events muss nach dessen Beginn sein!") unless end_date > date
    end
  end
  
end
