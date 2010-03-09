class UserPicturesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    
    respond_to do |format|
      format.ajax
    end
  end

  def create
    @user = User.find(params[:user_id])

    # destroy the old one...
    @user.user_picture.destroy if @user.user_picture

    pic = UserPicture.create(params[:uploaded_data])
    pic.user = @user


    if pic.save()
      flash[:notice] = "Das Bild wurde erfolgreich gespeichert."
      respond_to do |format|
        format.html { redirect_to players_path(@user.player) }
      end
    else
      flash[:notice] = "Das Bild konnte nicht gespeichert werden."
      respond_to do |format|
        format.html { redirect_to players_path(@user.player) }
      end
    end

  end

end