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
      result << find(:all, :conditions => ["date > ?", Time.now])
    end
    result.flatten
  end

  def self.next_event
    find(:first, :conditions => ["date > :now", {:now => Time.now}], :order => "date ASC")
  end
  
  def name
    title
  end

end
