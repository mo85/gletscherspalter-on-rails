class Address < ActiveRecord::Base
  belongs_to :location
  
  validates_presence_of :zip, :street, :city
  
  def to_s
    "#{street} #{number}, #{zip} #{city}"
  end
  
end
