class Trainingscamp < Event
  validates_presence_of :location_id
  
  def name
    "Trainingslager"
  end
  
end