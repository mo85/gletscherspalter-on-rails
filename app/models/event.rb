class Event < ActiveRecord::Base

  validates_presence_of :title, :date, :location

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

end
