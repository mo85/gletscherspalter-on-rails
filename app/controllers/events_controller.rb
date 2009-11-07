class EventsController < ApplicationController
  filter_access_to :all

  # GET /events
  def index
    @events = Event.find(:all, :order => "date DESC")

    respond_to do |format|
      format.html 
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

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Ereignis erfolgreich erstellt.'
        format.html { redirect_to(events_path) }
      else
        format.html { render :action => "new" }
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
