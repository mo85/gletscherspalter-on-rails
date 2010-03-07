class GamesController < ApplicationController
  
  filter_access_to :all
  after_filter :invalidate_stats_cache, :only => [:create, :update, :destroy]
  
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
  
  # GET /games/new
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.ajax.erb
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
        flash[:notice] = 'Spiel wurde erfolgreich angepasst.'
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
      flash[:notice] = "Spiel wurde gelöscht."
      format.html { redirect_to(games_url) }
    end
  end

  private

  def invalidate_stats_cache
    expire_fragment(:controller => "seasons", :action => "statistics", :id => @game.season.id)
  end
end
