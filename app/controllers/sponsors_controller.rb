# encoding: utf-8 
require 'digest/sha1'

class SponsorsController < ApplicationController

  filter_access_to :all

  # GET /users
  def index
    @title = "Gönner des EHC Gletscherspalter"
    @confirmed_sponsors = Sponsor.where("sponsorship_payed == ?", true)
    @unconfirmed_sponsors = Sponsor.where("sponsorship_payed == ?", false)

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
    @sponsor.login = create_login
    @sponsor.password = "sponsor"

    respond_to do |format|
      if @sponsor.save
        flash[:notice] = "Sie haben sich erfolgreich registriert."
        format.html { redirect_to(:action => 'index') }
      else
        format.html {render :action => "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @sponsor = Sponsor.find(params[:id])
    respond_to do |format|
      if @sponsor.update_attributes(params[:sponsor])
        flash[:notice] = "Gönner #{@sponsor.full_name} erfolgreich angepasst."
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
