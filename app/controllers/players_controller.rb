# encoding: utf-8 
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
    @players = User.find_all_by_is_player(true).collect(&:player).group_by(&:position)
    @title = "Gletscherspalter.ch::Spieler"
    
    respond_to do |format|
      if request.xhr?
        format.js { render :partial => "index", :locals => { :players => @players } }
      else
        format.html
      end
      
    end
  end
  
  def team
    @players = User.find_all_by_is_player(true).collect(&:player).group_by(&:position)
    
    respond_to do |format|
      format.html
    end
  end

  # GET /players/1
  def show
    @player = Player.find(params[:id])
    user = @player.user
    @events = user.events_of_current_season.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      if request.xhr?
        format.js { render :partial => "current_events", :locals => {:events => @events} }
      else
        format.html
      end
    end
  end
  
  def events
    @events = current_season.events.future_events(SUBSCRIPTION_TOLERANCE)
    
    if params[:token]
      @user = current_user
      @player = @user.player
    else 
      @player = Player.find(params[:id])
    end
    
    respond_to do |format|
      format.html
      format.pdf do
        @events = @player.user.events
        render :file => "players/events.pdf.prawn", :locals => { :events => @events, :player => @player }
      end
      format.ics do
        send_data(@player.user.events_to_ical(request.raw_host_with_port), :type => 'text/calendar',
                  :disposition => "inline; filename=Gletscherspalter.ics",
                  :filename => "Gletscherspalter.ics")
      end
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
  
  def new
    @user = User.find(params[:user_id])
    
    if !@user.player
      @player = Player.new
    end
    
    respond_to do |format|
      format.ajax
    end
  end
  
  def create
    @player = Player.new(params[:player])
    
    if @player.save
      flash[:notice] = "Spieler wurde erfolgreich erstellt."
    else
      flash[:notice] = "Spieler konnte nicht erstellt werden."
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
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

end
