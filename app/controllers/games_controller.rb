class GamesController < ApplicationController
  
  filter_access_to :all
  
  # GET /games
  def index
    @title = "Gletscherspatler.ch::Spiele"
    @games = current_season.games.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html
      format.pdf do
        @events = current_season.games
        render :file => "/players/events.pdf.prawn", :locals => { :events => @events } 
      end
    end
  end

  # GET /games/1
  def show
    @game = Game.find(params[:id])
    @players = @game.players.group_by(&:position)
    
    @scores = @game.scores.sort{|a,b| ((a.goals || 0) + (a.assists || 0)) <=> ((b.goals || 0) + (b.assists || 0))}.reverse
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def remove_player
    @game = Game.find(params[:id])
    player = Player.find(params[:p_id])
    @game.users.delete(player.user)
    
    respond_to do |format|
      format.html { redirect_to @game }
    end
  end
  
  def add_player
    @game = Game.find(params[:id])
    
    respond_to do |format|
      format.ajax
    end
  end
  
  def save_added_player
    @game = Game.find(params[:id])
    
    user_names = params[:usr_name].split(" ")
    begin
      player = User.find_by_firstname_and_lastname(user_names[0],user_names[1]).player
    rescue
      player = nil
    end
    
    if (valid_player = @game.valid_player?(player))
      players = @game.players
      player_added = false
      
      if !players.include?(player) 
        @game.users << player.user
        player_added = true
      end
    end 

    respond_to do |format|
      if valid_player && player_added
        flash[:notice] = 'Spieler erfolgreich hinzugefügt.'
        format.html { redirect_to @game }
      elsif valid_player
        flash[:notice] = 'Spieler ist bereits eingetragen.'
        format.html { redirect_to @game }
      else
        format.html { render :action => "add_player" }
      end
      
    end
  end

  # GET /games/new
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  def create
    @game = Game.new(params[:game])
    @game.season_id = current_season.id
    
    respond_to do |format|
      if @game.save
        flash[:notice] = 'Spiel erfolgreich erstellt.'
        expire_page(:controller => "seasons", :action => "statistics", :id => current_season.id)
        format.html { redirect_to(@game) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /games/1
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        expire_page(:controller => "seasons", :action => "statistics", :id => current_season.id)
        flash[:notice] = 'Spiel wurde erfolgreich angepasst.'
        format.html { redirect_to(games_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /games/1
  def destroy
    expire_page(:controller => "seasons", :action => "statistics", :id => current_season.id)
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      flash[:notice] = "Spiel wurde gelöscht."
      format.html { redirect_to(games_url) }
    end
  end
end
