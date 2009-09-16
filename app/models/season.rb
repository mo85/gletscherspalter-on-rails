class Season < ActiveRecord::Base
  
  has_many :games
  
  validates_presence_of :start_year
  validates_presence_of :end_year
  validates_numericality_of :start_year
  validates_numericality_of :end_year
  
  # def self.current
  #   last_stored_season = Season.find(:first, :order => "start_year DESC")
  #   @current_season = last_stored_season
  #   if @current_season == nil || (Time.now.year >= last_stored_season.end_year && Time.now.month > 7)
  #     # create new Season if e. g. last_season is 2009/2010 AND Month is August
  #     @current_season = Season.create(:start_year => Time.now.year, :end_year => Time.now.year + 1)
  #   end
  #   @current_season
  # end

  def self.current
    s = Season.find(:all)
  end
  
  def to_s
    "#{start_year}/#{end_year}"
  end
  
end
