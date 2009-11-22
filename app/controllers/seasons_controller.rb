class SeasonsController < ApplicationController
  
  def index
    @seasons = Season.all :order => "created_at DESC"
    
    respond_to do |format|
      format.html
    end
  end
  
  def statistics
    @season = Season.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
end