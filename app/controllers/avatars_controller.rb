class AvatarsController < ApplicationController
  
  def new
    @user = User.find(params[:user_id])
    
    @avatar = Avatar.new
    
    respond_to do |format|
      format.ajax
    end
  end

  def create
    if params[:avatar]
      @user = User.find(params[:user_id])
      # destroy the old one...
      @user.avatar.destroy if @user.avatar

      pic = Avatar.new params[:avatar]
      pic.user = @user

      if pic.save()
        flash[:notice] = "Das Bild wurde erfolgreich gespeichert."
      else
        flash[:notice] = "Das Bild konnte nicht gespeichert werden."
      end
      
      respond_to do |format|
        format.html { redirect_to player_path(@user.player) }
      end
      
    else
      flash[:notice] = "Invalid parameters."
      respond_to do |format|
        format.html { redirect_to player_path(@user.player) }
      end
    
    end
    
  end
  
end
