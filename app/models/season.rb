class Season < ActiveRecord::Base

  has_many :games
  
  validates_presence_of :start_year
  validates_presence_of :end_year
  validates_numericality_of :start_year
  validates_numericality_of :end_year

  def self.current
    year = Time.now.year
    next_year = year + 1
    
    @season = Season.find(:first, :conditions => ["start_year = ? AND end_year = ?", year, next_year])
    
    if !@season 
      if Time.now.month > 7
        @season = Season.create(:start_year => next_year, :end_year => next_year + 1)
      else
        @season = Season.create(:start_year => year, :end_year => next_year)
      end 
    end
    @season
  end
  
  def to_s
    "#{start_year}/#{end_year}"
  end

  
end
