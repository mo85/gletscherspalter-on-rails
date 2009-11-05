class GamesController < ApplicationController
  
  filter_access_to :all
  
  # GET /games
  def index
    @title = "Gletscherspatler.ch::Spiele"
    @games = current_season.games
    respond_to do |format|
      format.html
    end
  end

  # GET /games/1
  def show
    @game = Game.find(params[:id])
    @players = @game.players.group_by(&:position)
    @scores = @game.scores.sort{|a,b| (a.goals + a.assists) <=> (b.goals + b.assists)}.reverse
    
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def edit_scores
    @game = Game.find(params[:id])
    @scores = @game.scores
  end
  
  def remove_player
    @game = Game.find(params[:id])
    player = Player.find(params[:p_id])
    @game.players.delete(player)
    
    respond_to do |format|
      format.html { redirect_to @game }
    end
  end
  
  def add_player
    @game = Game.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def save_added_player
    @game = Game.find(params[:id])
    
    user_names = params[:usr_name].split(" ")
    player = User.find_by_firstname_and_lastname(user_names[0],user_names[1]).player
    
    @game.players << player
    
    respond_to do |format|
      format.html { redirect_to @game }
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

    respond_to do |format|
      if @game.save
        current_season.games << @game
        flash[:notice] = 'Game was successfully created.'
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
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(games_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /games/1
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
    end
  end
end
