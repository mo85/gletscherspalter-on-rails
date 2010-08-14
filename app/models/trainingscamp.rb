class Trainingscamp < Event
  validates_presence_of :locality, :end_date
  
  def name
    "Trainingslager"
  end
  
end