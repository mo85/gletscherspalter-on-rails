class Season < ActiveRecord::Base
  
  has_many :games
  
  validates_presence_of :start_year
  validates_numericality_of :start_year
  
  def self.current
    @current_season ||= Season.create(:start_year => Time.now.year, :end_year => Time.now.year + 1)
  end
  
end
