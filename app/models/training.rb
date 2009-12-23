class Training < Event
  validates_presence_of :location_id
  
  def name
    "Training"
  end
  
  def locality
    location.name
  end
  
end