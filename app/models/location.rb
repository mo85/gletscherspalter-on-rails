class Location < ActiveRecord::Base
  has_one :address, :dependent => :destroy
  
  validates_presence_of     :name
  validates_uniqueness_of   :name
  
end
