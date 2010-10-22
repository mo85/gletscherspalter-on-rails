# encoding: utf-8 
class RinksController < ApplicationController

  def edit
    @rink = Rink.find(params[:id])
  end
  
  def update

    @rink = Rink.find(params[:id])
    @address = @rink.address
    respond_to do |format|
      if @address.update_attributes(params[:address]) && @rink.update_attributes(params[:rink])
        expire_page "/root/locations"
        flash[:notice] = "Eisfeld #{@rink.name} erfolgreich angepasst."
        format.html { redirect_to(locations_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    expire_page "/root/locations"
    respond_to do |format|
      flash[:notice] = "Eisfeld #{@location.name} gelöscht."
      format.html { redirect_to(locations_url) }
    end
  end

end
