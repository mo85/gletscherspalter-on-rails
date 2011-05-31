# encoding: utf-8
class Sponsor < ActiveRecord::Base
  
  validates_presence_of     :firstname, :lastname, :email, :city, :zip, :street, :number
  validates_numericality_of :zip, :greater_than => 999, :less_than => 10000, :only_integer => true
  
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => false
  
  validate :gender_types
  
  ::Genders = { 'm' => 'Männlich', 'f' => 'Weiblich'}
  
  default_scope order("lastname ASC")

  def to_s
    "#{lastname} #{firstname}"
  end
  
  def address
    "#{zip} #{city}"
  end
  
  def self.gender_as_string key
    Sponsor::Genders[key]
  end
  
  def gender_types
    if gender != 'm' && gender != 'f' && gender != nil
      errors.add_to_base("Geschlecht muss angegeben werden")
    end
  end

end