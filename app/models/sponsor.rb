class Sponsor < ActiveRecord::Base
  
  validates_presence_of     :email, :city, :zip, :street, :number
  validates_numericality_of :zip, :greater_than => 999, :less_than => 10000, :only_integer => true
  
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => false
  
  def to_s
    "#{firstname} #{lastname}"
  end
  
  def address
    "#{zip} #{city}"
  end
  
end