# encoding: utf-8 
require 'digest/sha1'

class SponsorsController < ApplicationController
  validates_captcha

  filter_access_to :all

  # GET /users
  def index
    @title = "Gönner des EHC Gletscherspalter"
    @confirmed_sponsors = Sponsor.find_all_by_sponsorship_payed(true)
    @unconfirmed_sponsors = Sponsor.find_all_by_sponsorship_payed(false)

    respond_to do |format|
      format.html
    end
  end

  def new
    @title = "Neuer Gönner"
    @sponsor = Sponsor.new

    respond_to do |format|
      format.html
    end
  end

  # GET /users/1/edit
  def edit
    @title = "Gönner anpassen"
    @sponsor = Sponsor.find(params[:id])
  end

  # POST /users
  def create
    @sponsor = Sponsor.new(params[:sponsor])
    

    respond_to do |format|
      if captcha_validated? & @sponsor.valid?
        @sponsor.save
        mails = UserMailer.new_supporter(@sponsor)
        if mails
          mails.deliver
        end
        flash[:notice] = "Sie haben sich erfolgreich registriert."
        format.html { redirect_to(:action => 'index') }
      else
        flash[:notice] = "Die Angaben sind entweder unvollständig oder die Sicherheitsprüfung ist Fehlgeschlagen. <br /><strong>Bitte vervollständigen Sie die verlangten Informationen</strong>."
        format.html {render :action => "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @sponsor = Sponsor.find(params[:id])
    respond_to do |format|
      if @sponsor.update_attributes(params[:sponsor])
        flash[:notice] = "Gönner #{@sponsor} erfolgreich angepasst."
        format.html { redirect_to(:action=>'index') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @sponsor = Sponsor.find(params[:id])
    begin
      flash[:notice] = "Gönner gelöscht."
      @sponsor.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(sponsors_url) }
    end
  end
  
  private
  
  def create_login
    Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by { rand }.join)[0..5]
  end
  
end
