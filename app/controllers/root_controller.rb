class RootController < ApplicationController

  ::GMAPS_API_KEY = "ABQIAAAA5HvxKEk6euzB7DUyH0_WQRTpKOENAK7M60P_iZyjsCmeWfdXDBRvBLY2QxpZG45FwPCzYLQvO4CdXw"

  def index
    @title = "Gletscherspalter.ch::Home"
    @news = News.all :limit => 2
    
    @games = current_season.games.future_games :limit => 3
    @events = Event.future_events
  end
  
  def contact
    @title = "Gletscherspalter.ch::Kontakt"
  end
  
  def locations
    @title = "Gletscherspalter.ch::Orte"
    @rinks = Rink.all
  end

end
