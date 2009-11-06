class PlayersController < ApplicationController
  filter_access_to :all
  filter_access_to :games, :attribute_check => true
  filter_access_to :edit, :attribute_check => true
  

  ::PLAYER_POSITIONS = [
    ["Stürmer", "FW"],
    ["Verteidiger", "BW"],
    ["Goalie", "G"]
  ]
  
  ::SUBSCRIPTION_TOLERANCE = 1.day
  
  # GET /players
  # GET /players.xml
  def index
    @players = Player.all.group_by(&:position)
    @title = "Gletscherspalter.ch::Spieler"
    
    respond_to do |format|
      format.html # insufficientcredentials.html.erb
      format.xml  { render :xml => @players }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])
    @games = @player.games_of_season
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end
  
  def games
    @title = "Gletscherspalter.ch::Spiele Saison #{current_season.to_s}"
    @games = future_games_of_current_season
    @player = Player.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def update_games
    current_player = Player.find(params[:id])
    params[:player][:game_ids] ||= []
    params[:player][:game_ids] << current_player.games.passed_games
    params[:player][:game_ids] = params[:player][:game_ids].flatten.compact
    current_player.update_attributes(params[:player])
    
    respond_to do |format|
      format.html { redirect_to player_path(current_user.player) }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    @player = Player.find(params[:id])
    user = @player.user
    
    if params[:user][:pwd_changed]
      user.validate_new_password(params[:user][:password],params[:user][:password_confirmation])
      user.password= params[:user][:password]
      params[:user].delete(:pwd_changed)
    end
    
    respond_to do |format|
      if user.update_attributes(params[:user]) && @player.update_attributes(params[:player])
        flash[:notice] = 'Player was successfully updated.'
        format.html { redirect_to(@player) }
        format.xml  { head :ok }
      else
        flash[:error] = "Player update failed."
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def future_games_of_current_season
    @games ||= current_season.games.find(:all, :conditions => ["date >= ?", Time.now + SUBSCRIPTION_TOLERANCE])
  end
  
end
