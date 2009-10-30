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
    
    respond_to do |format|
      format.html # show.html.erb
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
