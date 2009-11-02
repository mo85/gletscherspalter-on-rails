# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  before_filter :set_current_user_for_authorization
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '51361ace22fc71942fa939641421594c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

protected
  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def current_user
    u_id = session[:user_id]
    @current_user ||= User.find(u_id) if u_id
  end
  helper_method :current_user
  
  def set_current_user_for_authorization
    Authorization.current_user = current_user
  end
  
  def set_current_user_as_stamper
    User.stamper = current_user
  end
  
  def current_season
    Season.current
  end
  helper_method :current_season

end
