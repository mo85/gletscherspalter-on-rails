class Trainingscamp < Event
  validates_presence_of :locality
  
  def name
    "Trainingslager"
  end
  
end