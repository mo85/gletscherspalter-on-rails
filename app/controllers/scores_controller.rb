class ScoresController < ApplicationController
  
  filter_access_to :all
  
  def edit
    @game = Game.find(params[:game_id])
    @score = Score.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @score = Score.new
    @game = Game.find(params[:game_id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @score = Score.find(params[:id])
    @game = @score.game
    update_params
    
    respond_to do |format|
      if @score.update_attributes(params[:score])
        flash[:notice] = 'Skore-Eintrag erfolgreich angepasst.'
        format.html { redirect_to(game_path(@game)) }
      else
        format.html { render :action => "edit", :locals => { :score => @score } }
      end
    end
  end
  
  def create
    @game = Game.find(params[:game_id])
    @score = @game.scores.build
    update_params
    
    respond_to do |format|
      if @score.update_attributes(params[:score])
        flash[:notice] = 'Skore-Eintrag erfolgreich hinzugefügt.'
        format.html { redirect_to(game_path(:id => params[:game_id])) }
      else
        format.html { render :action => "new", :locals => { :score => @score } }
      end
    end
  end

  def destroy
    @score = Score.find(params[:id])
    @score.destroy
    @game = Game.find(params[:game_id])
    respond_to do |format|
      flash[:notice] = 'Skore-Eintrag erfolgreich gelöscht.'
      format.html { redirect_to(game_path(@game.id)) }
    end
  end
  
  private
  
  def update_params
    player_names = params[:score][:player].split(" ")
    
    user = User.find_by_firstname_and_lastname(player_names[0], player_names[1])
    if user
      params[:score][:player_id] = user.player.id
    else
      params[:score][:player_id] = ""
    end
    
    params[:score][:game_id] = params[:game_id]
    params[:score].delete(:player)
  end
  
end