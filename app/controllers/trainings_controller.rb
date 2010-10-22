# encoding: utf-8 
class TrainingsController < ApplicationController
  
  filter_access_to :all
  
  def show
    @event = Training.find(params[:id])
    @players = @event.group_players_by_position
    
    @comment = Comment.new
    @comments = @event.comments
    respond_to do |format|
      format.html { render :template => "events/show", :locals => { :event => @event }}
    end
  end
  
  def new
    @training = Training.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @training = Training.new(params[:training])
    @training.season_id = current_season.id
    
    respond_to do |format|
      if @training.save
        flash[:notice] = 'Training erfolgreich erstellt.'
        format.html { redirect_to(events_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @training = Training.find(params[:id])
  end
  
  def update
    @training = Training.find(params[:id])

    respond_to do |format|
      if @training.update_attributes(params[:training])
        flash[:notice] = 'Training erfolgreich angepasst.'
        format.html { redirect_to(events_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @training = Training.find(params[:id])
    @training.destroy

    respond_to do |format|
      flash[:notice] = "Training wurde gelöscht."
      format.html { redirect_to(events_path) }
    end
  end
  
end