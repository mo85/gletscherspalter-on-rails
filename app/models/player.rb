class Player < ActiveRecord::Base
  has_and_belongs_to_many :games, :order => "Date ASC"
  belongs_to :user

  # validation stuff
  validates_numericality_of :number, :allow_nil => true
  validate :number_must_not_be_negative
  validates_presence_of :position
  validates_presence_of :user_id
  validate :valid_position  
  
  ::Positions = {:BW => 'Verteidiger', :G => 'Goalie', :FW => 'Stürmer'}
  
  def position_as_string
    ::Positions[self.position.to_sym]
  end

  protected
  
    def number_must_not_be_negative
      errors.add(:number, ' must be positive') if number && number < 0
    end
    
    def valid_position
      if (position == "FW" || position == "BW" || position == "G")
      else 
        errors.add(:position, 'is invalid! Possibilities: Forwards - FW, Backs - BW, Goalies - G')
      end
    end 

end
