class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :index
  filter_access_to :all

  # GET /users
  def index
    @users = []
    
    if params[:usr_name] && !params[:usr_name].blank?
      @users = User.find_by_first_or_lastname(params[:usr_name])
    elsif params[:score] && !params[:score][:player].blank?
      @users = User.find_by_first_or_lastname(params[:score][:player])
    else
      @title = "Gletscherspatler.ch::Benutzer"
      @users = User.find(:all, :order => :lastname)
    end
    
    respond_to do |format|
      format.html
      format.ajax
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    @user.login = "#{@user.firstname.downcase}.#{@user.lastname.downcase}"
    @user.password = "secret"
    
    respond_to do |format|
      if @user.save
        flash[:notice] = "Benutzer #{@user.full_name} wurde erstellt."
        format.html { redirect_to(:action => 'index') }
      else
        format.html {render :action => "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Benutzer #{@user.full_name} erfolgreich geändert."
        format.html { redirect_to(:action=>'index') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    begin
      flash[:notice] = t('user.deleted_flash')
      @user.destroy
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(users_url) }
    end
  end

end