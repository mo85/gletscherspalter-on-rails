class TrainingsController < ApplicationController
  
  filter_access_to :all
  
  def new
    @training = "hihi"
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @training = "hihi"
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @training = "hihi"
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @training = "hihi"
  end
  
  def destroy
  end
  
  
end