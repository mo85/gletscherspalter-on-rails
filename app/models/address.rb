class Address < ActiveRecord::Base
  belongs_to :location
  
  validates_presence_of :zip, :street, :city
  validates_numericality_of :zip, :only_integer => true, :greater_than => 999, :less_than => 10000
  
  def to_s
    "#{street} #{number}, #{zip} #{city}"
  end
  
end
