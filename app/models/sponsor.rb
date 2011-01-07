class Sponsor < User
  
  validates_presence_of :email, :city, :zip
  
  def is_admin?
    false
  end
  
  def is_player?
    false
  end
  
end