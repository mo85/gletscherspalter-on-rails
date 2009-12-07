class RootController < ApplicationController
  
  filter_access_to :all
  
  # API key gletscherspalter.railsplayground.net
  #::GMAPS_API_KEY = "ABQIAAAA5HvxKEk6euzB7DUyH0_WQRTpKOENAK7M60P_iZyjsCmeWfdXDBRvBLY2QxpZG45FwPCzYLQvO4CdXw"
  
  # API 
  ::GMAPS_API_KEY = "ABQIAAAA5Cg2aLm1iTTYL6oUisE3ZBSuXVNLgnrcQJUWSG2AreT3guZgphSOO4UVDmj7UXBqb8uhZ0n4unLssg"
  
  #caches_page :contact
  #caches_page :locations
  
  def index
    @title = "Gletscherspalter.ch::Home"
    @news = News.find :all, :limit => 3, :order => "created_at DESC"
    
    @games = current_season.games.future_games :limit => 3
    @events = Event.future_events(:order => "date DESC", :limit => 3)
  end
  
  def contact
    @title = "Gletscherspalter.ch::Kontakt"
  end
  
  def locations
    if params[:id]
      @selected_rink = Rink.find(params[:id])
    end
    
    @title = "Gletscherspalter.ch::Orte"
    @rinks = Rink.all :order => "name ASC"
  end
  
end
