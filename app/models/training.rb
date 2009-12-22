class Training < Event
  
  def name
    "Training"
  end
  
  def locality
    location.name
  end
  
end