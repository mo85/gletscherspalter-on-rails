class TrainingscampsController < ApplicationController
  
  filter_access_to :all 
  
  def new
    @trainingscamp = "hihi"
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @trainingscamp = "hihi"
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @trainingscamp = "hihi"
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @trainingscamp = "hihi"
  end
  
  def destroy
  end
  
end