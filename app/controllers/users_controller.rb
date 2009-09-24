#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
class UsersController < ApplicationController

  before_filter  :authorize, :except => :myprofile 

  def sufficient_credentials?
    result = 0
    unless user_has_role('admin')
      result = nil 
    end
    result
  end

  # GET /users
  # GET /users.xml
  def index
    @title = "Gletscherspatler.ch::Benutzer"
    @users = User.find(:all, :order => :name)

    respond_to do |format|
      format.html # insufficientcredentials.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.user_name = "#{@user.first_name.downcase}.#{@user.name.downcase}"
    @user.password = "secret"
    respond_to do |format|
      if @user.save
        # create a player for the user!
        player = Player.new(:user_id => @user.id)
        player.save!
        flash[:notice] = "User #{@user.user_name} was successfully created."
        format.html { redirect_to(:action=>'index') }
        format.xml  { render :xml => @user, :status => :created,
                             :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User #{@user.user_name} was successfully updated."
        format.html { redirect_to(:action=>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    begin
      flash[:notice] = "User #{@user.user_name} deleted"
      @user.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

end