class Event < ActiveRecord::Base

  def date_formatted
    date.strftime("%d. %m. %Y %H:%M")
  end

  def self.find_future_events
    find(:all, :conditions => ["date > :now", {:now => Time.now}], :order => "date DESC", :limit => 3)
  end

  def self.next_event
    find(:first, :conditions => ["date > :now", {:now => Time.now}], :order => "date ASC")
  end

end
