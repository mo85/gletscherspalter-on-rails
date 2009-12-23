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
      if request.xhr?
        format.js { render :partial => "index", :locals => { :players => @players } }
      else
        format.html
      end
      
    end
  end

  # GET /players/1
  def show
    @player = Player.find(params[:id])
    @events = @player.user.events.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html
    end
  end
  
  # def games
  #   @title = "Gletscherspalter.ch::Spiele Saison #{current_season.to_s}"
  #   @games = future_games_of_current_season
  #   
  #   if params[:token]
  #     @user = current_user
  #     @player = @user.player
  #   else 
  #     @player = Player.find(params[:id])
  #   end
  #   
  #   respond_to do |format|
  #     format.html
  #     format.pdf do 
  #       games = @player.games
  #       render :file => "players/games.pdf.prawn", :locals => { :games => games } 
  #     end
  #     format.ics do
  #       send_data(@player.games_to_ical(request.raw_host_with_port), :type => 'text/calendar',
  #                 :disposition => "inline; filename=Gletscherspalter.ics",
  #                 :filename => "Gletscherspalter.ics")
  #     end
  #   end
  # end
  
  def events
    @events = current_season.events.future_events
    @player = Player.find params[:id]
    
    respond_to do |format|
      format.html
    end
  end
  
  def update_events
    current_player = Player.find(params[:id])
    
    params[:user] ||= {}
    params[:user][:event_ids] ||= []  
    params[:user][:event_ids] << current_player.user.events.passed_events
    params[:user][:event_ids] = params[:user][:event_ids].flatten.compact
    current_player.user.update_attributes(params[:user])
    
    respond_to do |format|
      flash[:notice] = "Anlässe erfolgreich angepasst."
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
    
    Player.transaction do
      @player.update_attributes!(params[:player])
      @user.update_attributes!(params[:user])
      flash[:notice] = 'Spieler wurde erfolgreich angepasst.'
      redirect_to(@player)
    end
    rescue ActiveRecord::RecordInvalid => e
      @player.valid?
      @user.valid? 
      render :action => "edit"
  end

  private
  
  def future_games_of_current_season
    @games ||= current_season.games.find(:all, :conditions => ["date >= ?", Time.zone.now + SUBSCRIPTION_TOLERANCE])
  end
  
end
