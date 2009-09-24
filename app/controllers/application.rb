# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '51361ace22fc71942fa939641421594c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

protected
  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?
  
  def authorize
    user = current_user
    if user.nil?
      #session[:original_uri] = request.request_uri
      redirect_to :controller => 'admin', :action => 'login'
    else
      unless sufficient_credentials?
        redirect_to :controller => 'admin', :action => 'insufficientcredentials'
      end
    end

  end
  
  def privilege_value(user_role)
    @@privilege_hash[user_role]
  end
  helper_method :privilege_value

  def user_has_role(role)
    user = current_user
    if !user.nil?
      unless highest_privilege(user.user_roles) >= @@privilege_hash[role]
        user = nil
      end
    end
    user
  end
  helper_method :user_has_role

  def sufficient_credentials?
    nil
  end

  def current_user
      User.find_by_id(session[:user_id])
  end
  helper_method :current_user
  
  def current_season
    Season.current
  end
  helper_method :current_season

private

  def highest_privilege(user_roles)
    highest_privilege = 0
    user_roles.each do |user_role|
      if user_role.role.classification > highest_privilege
        highest_privilege = user_role.role.classification
      end
    end
    highest_privilege
  end 

  @@privilege_hash = {"developer" => 10,"admin" => 8, "active" => 6, "passive" => 4, "guest" => 2, "none" => 0}
end
