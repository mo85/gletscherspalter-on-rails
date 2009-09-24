class GamesController < ApplicationController
  
  before_filter :authorize

  def sufficient_credentials?
    result = 0
    unless user_has_role('active')
      result = nil
    end
    result
  end
  
  def subscribable
    @title = "Gletscherspalter.ch::Spiele Saison #{current_season.to_s}"
    @games = current_season.games
    respond_to do |format|
      format.html
    end
  end
  
  def update_subscribable
    current_player = current_user.player
    current_season.games.each do |game|
      game.players.delete(current_player)
    end
    
    selected_games = Game.find(params[:game_ids])
    selected_games.each do |game|
      game.players << current_player
    end
    
    respond_to do |format|
      format.html { redirect_to player_path(current_user.player) }
    end
  end
  
  # GET /games
  # GET /games.xml
  def index
    @title = "Gletscherspatler.ch::Spiele"
    @games = Game.all.sort_by(&:date)
    respond_to do |format|
      format.html # insufficientcredentials.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])
    
    @players = @game.players.group_by(&:position)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game was successfully created.'
        format.html { redirect_to(@game) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(@game) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
end
