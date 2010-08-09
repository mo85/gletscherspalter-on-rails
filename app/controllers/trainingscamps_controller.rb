class TrainingscampsController < ApplicationController
  
  filter_access_to :all 
  
  def show
    @event = Trainingscamp.find(params[:id])
    @players = @event.group_players_by_position
    
    respond_to do |format|
      format.html { render :template => "events/show", :locals => { :event => @event }}
    end
  end
  
  def new
    @event = Trainingscamp.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @event = Trainingscamp.new(params[:trainingscamp])
    @event.season_id = current_season.id
    
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Trainingslager erfolgreich erstellt.'
        format.html { redirect_to(events_path) }
      else
        format.html { render(:action => "new") }
      end
    end
  end
  
  def edit
    @event = Trainingscamp.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @trainingscamp = Trainingscamp.find(params[:id])

    respond_to do |format|
      if @trainingscamp.update_attributes(params[:trainingscamp])
        flash[:notice] = 'Trainingslager erfolgreich angepasst.'
        format.html { redirect_to(events_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @trainingscamp = Trainingscamp.find(params[:id])
    @trainingscamp.destroy

    respond_to do |format|
      flash[:notice] = "Trainingslager wurde gelöscht."
      format.html { redirect_to(events_path) }
    end
  end
  
end