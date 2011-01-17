# encoding: utf-8 
class GuestnotesController < ApplicationController
  filter_access_to :all
  
  validates_captcha
  
  def index
    @notes = Guestnote.all.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @note = Guestnote.new

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
    
    respond_to do |format|
      if captcha_validated? && @note.save
        flash[:notice] = "Eintrag erfolgreich erstellt."
        format.html { redirect_to guestnotes_path }
      else
        flash[:notice] = "Der Eintrag konnte nicht gespeichert werden da die Sicherheitsprüfung negativ ausfiel."
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
  
end