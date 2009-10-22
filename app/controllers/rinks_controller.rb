class RinksController < ApplicationController

  def update
    @rink = Rink.find(params[:id])

    respond_to do |format|
      if @rink.update_attributes(params[:rink])
        flash[:notice] = 'Location was successfully updated.'
        format.html { redirect_to(locations_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rink.errors, :status => :unprocessable_entity }
      end
    end
  end

end
