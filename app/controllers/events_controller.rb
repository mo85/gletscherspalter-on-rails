class EventsController < ApplicationController
  filter_access_to :all
  
  # GET /events
  def index
    @events = current_season.events.find_all_non_game_events.paginate :page => params[:page], :per_page => 10
    
    respond_to do |format|
      format.html
      format.pdf
    end
  end
  
  def show
    @event = Event.find params[:id]
    @users = @event.users
    @players = @event.group_players_by_position
    
    @comment = Comment.new
    @comments = @event.comments
    respond_to do |format|
      format.html
    end
  end
  
  def add_comment
    @event = Event.find(params[:id])
    
    unless params[:comment].blank?
      @event.comments.create(:comment => params[:comment][:comment], :user_id => current_user.id)
    end
    
    respond_to do |format|
      format.html { redirect_to @event }
    end
  end

  # GET /events/new
  def new
    @event = Event.new

    respond_to do |format|
      format.html
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  def create
    @event = Event.new(params[:event])
    @event.season_id = current_season.id
    
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Ereignis erfolgreich erstellt.'
        format.html { redirect_to(events_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def remove_player
    @event = Event.find(params[:id])
    player = Player.find(params[:p_id])
    @event.users.delete(player.user)
    
    respond_to do |format|
      format.html { redirect_to :controller => @event.controller_name, :action => "show", :id => @event.id }
    end
  end
  
  def add_player
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.ajax
    end
  end
  
  def save_added_player
    @event = Event.find(params[:id])
    
    user_names = params[:usr_name].split(" ")
    begin
      player = User.find_by_firstname_and_lastname(user_names[0],user_names[1]).player
    rescue
      player = nil
    end
    
    if (valid_player = @event.valid_player?(player))
      players = @event.players
      player_added = false
      
      if !players.include?(player) 
        @event.users << player.user
        player_added = true
      end
    end 

    respond_to do |format|
      if valid_player && player_added
        flash[:notice] = 'Spieler erfolgreich hinzugefügt.'
        format.html { redirect_to :controller => @event.controller_name, :action => "show", :id => @event.id }
      elsif valid_player
        flash[:notice] = 'Spieler ist bereits eingetragen.'
        format.html { redirect_to :controller => @event.controller_name, :action => "show", :id => @event.id }
      else
        format.html { render :action => "add_player" }
      end
      
    end
  end
  
  
  # PUT /events/1
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Ereignis erfolgreich angepasst.'
        format.html { redirect_to(events_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      flash[:notice] = "Ereignis wurde gelöscht."
      format.html { redirect_to(events_path) }
    end
  end

end
