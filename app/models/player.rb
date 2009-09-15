class Player < ActiveRecord::Base
  has_and_belongs_to_many :games
  belongs_to :user

  # validation stuff
  
  #validates_numericality_of :number
  #validate :number_must_not_be_negative
  #validate :valid_position  

  protected
  
    def number_must_not_be_negative
      errors.add(:number, ' must be positive') if (number.nil? || number < 0)
    end
    
    def valid_position
      if (position == "FW" || position == "BW" || position == "G")
      else 
        errors.add(:position, 'is invalid! Possibilities: Forwards - FW, Backs - BW, Goalies - G')
      end
    end 

end
