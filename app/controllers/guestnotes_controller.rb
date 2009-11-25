class GuestnotesController < ApplicationController
  
  def index
    @notes = Guestnote.all :order => "created_at DESC"
    respond_to do |format|
      format.html
    end
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def destroy
    
  end
  
end