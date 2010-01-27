class Event < ActiveRecord::Base

  has_and_belongs_to_many :users
  belongs_to :location
  belongs_to :season

  validates_presence_of :date, :season_id
  
  def players
    users.collect(&:player)
  end
  
  def date_formatted
    I18n.l(date, :format => :default)
  end

  def self.future_non_game_events(options = {})
    result = []
    with_scope :find => options do
      result << find(:all, :conditions => ["date > ? AND type != ?", Time.zone.now, "Game"])
    end
    result.flatten
  end
  
  def self.find_all_non_game_events
    find(:all, :conditions => ["type != ?", "Game"])
  end

  def self.next_non_game_event
    find(:first, :conditions => ["type != ? AND date > ?", "Game", Time.zone.now ], :order => "date ASC")
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
      result << find(:all, :conditions => ["date > ?", Time.zone.now + tolerance], :order => "date ASC")
    end
    result.flatten
  end
  
  def self.passed_events
    find :all, :conditions => ["date < ?", Time.zone.now]
  end
  
  def result
    "-"
  end
  
  def self.games
    find :all, :conditions => ["type = ?", "Game"]
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
end
