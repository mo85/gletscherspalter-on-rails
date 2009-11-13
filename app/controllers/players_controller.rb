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
  def index
    @players = Player.all.group_by(&:position)
    @title = "Gletscherspalter.ch::Spieler"
    
    respond_to do |format|
      format.html
    end
  end

  # GET /players/1
  def show
    @player = Player.find(params[:id])
    @games = @player.games_of_season
    respond_to do |format|
      format.html
    end
  end
  
  def games
    @title = "Gletscherspalter.ch::Spiele Saison #{current_season.to_s}"
    @games = future_games_of_current_season
    
    if params[:token]
      @user = current_user
      @player = @user.player
    else 
      @player = Player.find(params[:id])
    end
    
    respond_to do |format|
      format.html
      format.ics do
        send_data(@player.games_to_ical(request.raw_host_with_port), :type => 'text/calendar',
                  :disposition => "inline; filename=Gletscherspalter.ics",
                  :filename => "Gletscherspalter.ics")
      end
    end
  end
  
  def update_games
    current_player = Player.find(params[:id])
    params[:player][:game_ids] ||= []
    params[:player][:game_ids] << current_player.games.passed_games
    params[:player][:game_ids] = params[:player][:game_ids].flatten.compact
    current_player.update_attributes(params[:player])
    
    respond_to do |format|
      flash[:notice] = "Spiele erfolgreich angepasst."
      format.html { redirect_to player_path(current_user.player) }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
    @user = @player.user
  end

  # PUT /players/1
  def update
    @player = Player.find(params[:id])
    @user = @player.user
    
    if params[:user][:pwd_changed]
      @user.validate_new_password(params[:user][:password], params[:user][:password_confirmation])
      @user.password= params[:user][:password]
      params[:user].delete(:pwd_changed)
    else
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    
    respond_to do |format|
      if @user.update_attributes(params[:user]) && @player.update_attributes(params[:player])
        flash[:notice] = 'Spieler wurde erfolgreich angepasst.'
        format.html { redirect_to(@player) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
  
  def future_games_of_current_season
    @games ||= current_season.games.find(:all, :conditions => ["date >= ?", Time.now + SUBSCRIPTION_TOLERANCE])
  end
  
end
