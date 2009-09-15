class RootController < ApplicationController
  
  ::GMAPS_API_KEY = "ABQIAAAA5HvxKEk6euzB7DUyH0_WQRTLWApyOJxO8-zwgJkTpfUwr94z8RRRkK67SZ7VI42cix2lopKQKPSr3A"
  
  def index
    @title = "Gletscherspalter.ch::Home"
  end
  
  def contact
    @title = "Gletscherspalter.ch::Kontakt"
  end
  
  def locations
    @title = "Gletscherspalter.ch::Orte"
    @rinks = Rink.all
  end

  def season
    @title = "Gletscherspalter.ch::Saison"
    @events = Event.find_future_events
    @games = Game.find_games
  end

  def register
    @title = "Gletscherspalter.ch::Absenzen"
    @games = Game.find_games
  end

  def myprofile
    @user = current_user
  end

end
