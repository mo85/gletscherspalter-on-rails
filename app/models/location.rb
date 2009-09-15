class Location < ActiveRecord::Base
  has_one :address
  
  validates_presence_of :url, :name
  
  def self.find_all_locations
    find(:all, :order => "name")
  end
end
