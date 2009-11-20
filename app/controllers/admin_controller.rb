class AdminController < ApplicationController
  def login
    @title = "Gletscherspatler.ch::Login"
    if request.post?
      user = User.authenticate(params[:user_name], params[:password])
      if user
        session[:user_id] = user.id
        #uri = session[:original_uri]
        #session[:original_uri] = nil
        #redirect_to(uri || { :controller => "root", :action => "index" })
        redirect_to(:controller => "root", :action => "index")
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    @title = "Gletscherspalter.ch::Logout"
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:controller => 'root')
  end

end
