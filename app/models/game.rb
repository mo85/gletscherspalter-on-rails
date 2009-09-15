class Game < ActiveRecord::Base
  
  has_and_belongs_to_many :players
  belongs_to :rink
  belongs_to :season
  
  validates_presence_of :rink, :opponent
  validates_format_of :result, :with => /([0-9]):([0-9])/, :allow_blank => true
  
  def self.last_game
    last(:order => "date ASC", :conditions => ["result != ?",""])
  end
  
  def date_formatted
    date.strftime("%d. %m. %Y %I:%M %p")
  end

  def self.find_games
    find(:all, :order => "date DESC")
  end

  def self.next_game
    find(:first, :conditions => ["date > :now", {:now => Time.now}], :order => "date ASC") 
  end
  
end
