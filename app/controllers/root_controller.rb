class RootController < ApplicationController
  
#  old...
#  ::GMAPS_API_KEY = "ABQIAAAA5HvxKEk6euzB7DUyH0_WQRTLWApyOJxO8-zwgJkTpfUwr94z8RRRkK67SZ7VI42cix2lopKQKPSr3A"#
  
 # ::GMAPS_API_KEY_2 = "ABQIAAAA5HvxKEk6euzB7DUyH0_WQRQHckxr0pSFNOpEE-nR8624c0XaDRRjdNEc3FC-_bytIonRIlbhhXaKOQ"
  
  ::GMAPS_API_KEY = "ABQIAAAA5HvxKEk6euzB7DUyH0_WQRQHckxr0pSFNOpEE-nR8624c0XaDRRjdNEc3FC-_bytIonRIlbhhXaKOQ"
  def index
    @title = "Gletscherspalter.ch::Home"
    future_games = current_season.games.select{|g| g.date > Time.now}
    @events = Event.future_events
    if future_games.empty?
      @games = []
    elsif future_games.size == 1
      @games = future_games
    else
      @games = future_games.values_at(0,1)
    end
  end
  
  def contact
    @title = "Gletscherspalter.ch::Kontakt"
  end
  
  def locations
    @title = "Gletscherspalter.ch::Orte"
    @rinks = Rink.all
  end

end
