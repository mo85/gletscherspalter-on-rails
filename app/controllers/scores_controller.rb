class ScoresController < ApplicationController
  
  filter_access_to :all
  
  def edit
    if session[:crappy_score]
      @score = session[:crappy_score]
      session[:crappy_score] = nil
    else
      @score = Score.find(params[:id])
    end
    @game = Game.find(params[:game_id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    if session[:crappy_score]
      @score = session[:crappy_score]
      session[:crappy_score] = nil
    else
      @score = Score.new
    end
    @game = Game.find(params[:game_id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @score = Score.find(params[:id])
    update_params
    
    respond_to do |format|
      if @score.update_attributes(params[:score])
        flash[:notice] = 'Skore-Eintrag erfolgreich angepasst.'
        format.html { redirect_to(game_path(:id => params[:game_id])) }
      else
        session[:crappy_score] = @score
        format.html { redirect_to :back }
      end
    end
  end
  
  def create
    @score = Score.new(params[:id])
    update_params
    
    respond_to do |format|
      if @score.update_attributes(params[:score])
        flash[:notice] = 'Skore-Eintrag erfolgreich hinzugefügt.'
        format.html { redirect_to(game_path(:id => params[:game_id])) }
      else
        session[:crappy_score] = @score
        format.html { redirect_to :back }
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