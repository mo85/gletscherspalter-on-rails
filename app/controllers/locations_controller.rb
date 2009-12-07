class LocationsController < ApplicationController
  filter_access_to :all
  
  # GET /locations
  def index
    @locations = Location.find :all, :order => "name"

    respond_to do |format|
      format.html
    end
  end

  # GET /locations/1
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /locations/new
  def new
    @location = Location.new

    respond_to do |format|
      format.html
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  def create
    if params[:location][:type]
      clazz = eval(params[:location][:type].camelize)
      params[:location].delete(:type)
    else
      clazz = Location
    end
    
    @location = clazz.new(params[:location])

    @address = Address.new(params[:address])

    respond_to do |format|
      if @address.save && @location.save
        expire_page "/root/locations"
        @location.address = @address
        flash[:notice] = "Lokation #{@location.name} erfolgreich erstellt."
        format.html { redirect_to(locations_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /locations/1
  def update
    @location = Location.find(params[:id])
    @address = @location.address
    respond_to do |format|
      if @address.update_attributes(params[:address]) && @location.update_attributes(params[:location])
        expire_page "/root/locations"
        flash[:notice] = "Lokation #{@location.name} erfolgreich angepasst."
        format.html { redirect_to(locations_path) }
       else
        format.html { render :controller => "locations", :action => "edit" }
      end
    end
  end

  # DELETE /locations/1
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    
    expire_page "/root/locations"
    
    respond_to do |format|
      flash[:notice] = "Lokation #{@location.name} gelöscht."
      format.html { redirect_to(locations_url) }
    end
  end
end
