class RootController < ApplicationController
  
  filter_access_to :all
  
  def index
    @title = "Gletscherspalter.ch::Home"
    @news = News.find :all, :limit => 3, :order => "created_at DESC"
    
    @games = current_season.games.future_games :limit => 3
  end
  
  def contact
    @title = "Gletscherspalter.ch::Kontakt"
  end
  
  def locations
    @gmaps_api_key = APP_CONFIG["gmaps"]["api-key"]
    
    if params[:id]
      @selected_rink = Rink.find(params[:id])
    end
    
    @title = "Gletscherspalter.ch::Orte"
    @rinks = Rink.all :order => "name ASC"
  end

  def fb_news
    @last_game = Game.last_game
    @next_game = Game.next_game
  end

  def denied
    
  end
  
end
