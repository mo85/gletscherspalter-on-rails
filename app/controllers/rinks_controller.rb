class RinksController < ApplicationController

  def update
    @rink = Rink.find(params[:id])
    address = @rink.address
    respond_to do |format|
      if address.update_attributes(params[:address]) && @rink.update_attributes(params[:rink])
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(locations_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rink.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end

end
