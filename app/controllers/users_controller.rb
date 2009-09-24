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
    @users = User.find(:all, :order => :lastname)

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
    @user.login = "#{@user.firstname.downcase}.#{@user.lastname.downcase}"
    @user.password = "secret"
    @user.save
    player = Player.create(:position => "FW", :user_id => @user.id)

    respond_to do |format|
        format.html { redirect_to(:action => 'index') }
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