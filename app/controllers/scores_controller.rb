class ScoresController < ApplicationController
  
  filter_access_to :all
  
  def edit
    @score = Score.find(params[:id])
    @game = Game.find(params[:game_id])
    
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
    update_params
    
    respond_to do |format|
      if params[:score][:player_id] && @score.update_attributes(params[:score])
        flash[:notice] = 'Score was successfully updated.'
        format.html { redirect_to(game_path(:id => params[:game_id])) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def create
    @score = Score.new(params[:id])
    update_params

    respond_to do |format|
      if params[:score][:player_id] && @score.update_attributes(params[:score])
        flash[:notice] = 'Score was successfully created.'
        format.html { redirect_to(game_path(:id => params[:game_id])) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @score = Score.find(params[:id])
    @score.destroy
    @game = Game.find(params[:game_id])
    respond_to do |format|
      format.html { redirect_to(game_path(@game.id)) }
    end
  end
  
  private
  
  def update_params
    player_names = params[:score][:player].split(" ")
    
    user = User.find_by_firstname_and_lastname(player_names[0], player_names[1])
    if user
      params[:score][:player_id] = user.player.id
    end
    
    params[:score][:game_id] = params[:game_id]
    params[:score].delete(:player)
  end
  
end