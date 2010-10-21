# encoding: utf-8 
class GuestnotesController < ApplicationController
  filter_access_to :all
  
  def index
    @notes = Guestnote.all.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @note = Guestnote.new
    
    @random_no1 = rand(50)
    @random_no2 = rand(50)
    @token = generate_token(@random_no1 + @random_no2)
    
    respond_to do |format|
      format.ajax
    end
  end
  
  def edit
    @note = Guestnote.find params[:id]

    respond_to do |format|
      format.ajax
    end
  end
  
  def update
    @note = Guestnote.find params[:id]
    
    respond_to do |format|
      if @note.update_attributes(params[:guestnote])
        flash[:notice] = "Eintrag wurde erfolgreich editiert."
        format.html { redirect_to guestnotes_path }
      else
        flash[:notice] = "Die Änderungen waren unzulässig und konnten nicht gespeichert werden."
        format.html { redirect_to guestnotes_path }
      end
    end
  end
  
  def create
    @note = Guestnote.new(params[:guestnote])
    @token = params[:token]
    
    token_valid = @note.validate_token(@token, generate_token(params[:result].to_i))

    respond_to do |format|
      if token_valid && @note.save
        flash[:notice] = "Eintrag erfolgreich erstellt."
        format.html { redirect_to guestnotes_path }
      else
        flash[:notice] = "Eintrag konnte nicht gespeichert werden. Die Angaben waren entweder unvollständig oder falsch."
        format.html { redirect_to guestnotes_path }
      end
    end
  end
  
  def destroy
    @note = Guestnote.find(params[:id])
    @note.destroy
    
    respond_to do |format|
      flash[:notice] = "Eintrag gelöscht."
      format.html { redirect_to guestnotes_path }
    end
    
  end
  
  private
  
  def generate_token(number)
    Digest::SHA1.hexdigest("#{number.to_s} gletscherspalter.ch - goldies #{((0-number) * 5).to_s} - eat my shorts!")
  end
  
end