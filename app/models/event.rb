class Event < ActiveRecord::Base

  has_and_belongs_to_many :users
  belongs_to :location

  validates_presence_of :date, :season_id
  validates_numericality_of :score, :only_integer => true, :allow_nil => true
  validates_numericality_of :opponent_score, :only_integer => true, :allow_nil => true
  
  def date_formatted
    I18n.l(date, :format => :default)
  end

  def self.future_events(options = {})
    result = []
    with_scope :find => options do
      result << find(:all, :conditions => ["date > ?", Time.zone.now])
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

end
