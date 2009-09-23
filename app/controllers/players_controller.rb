class PlayersController < ApplicationController
  
  before_filter :authorize

  ::PLAYER_POSITIONS = [
    ["Stürmer", "FW"],
    ["Verteidiger", "BW"],
    ["Goalie", "G"]
  ]

  def sufficient_credentials?
    result = 0
    unless user_has_role('active')
      result = nil
    end
    result
  end
  
  # GET /players
  # GET /players.xml
  def index
    @players = Player.find(:all)
    @title = "Gletscherspalter.ch::Spieler"
    sortPlayers    
    
    respond_to do |format|
      format.html # insufficientcredentials.html.erb
      format.xml  { render :xml => @players }
    end
  end

  def sortPlayers
    @sortedPlayers = Hash.new
    forwards = Player.find(:all, :conditions => "position = 'FW'")
    backs = Player.find(:all, :conditions => "position = 'BW'")
    goalers = Player.find(:all, :conditions => "position = 'G'" )
    @sortedPlayers["Stürmer"] = forwards
    @sortedPlayers["Verteidiger"] = backs
    @sortedPlayers["Goalies"] = goalers
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        flash[:notice] = 'Player was successfully created.'
        format.html { redirect_to(@player) }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        flash[:notice] = 'Player was successfully updated.'
        format.html { redirect_to(@player) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
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
  
end
