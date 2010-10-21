class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all # include all helpers, all the time
  before_filter :set_current_user_for_authorization
  before_filter :set_locale
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '51361ace22fc71942fa939641421594c'
  
  #layout "maintenance"

protected
  def logged_in?
    session[:user_id]
  end
  helper_method :logged_in?

  def current_user
    if params[:token]
      @current_user ||= User.find_by_token(params[:token])
    elsif !@headless && session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
  helper_method :current_user
  
  def user_is_admin?
    logged_in? && current_user.is_admin
  end
  helper_method :user_is_admin?
  
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
  
  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale

    locale_path = "#{LOCALES_DIRECTORY}#{I18n.locale}.yml"

    unless I18n.load_path.include? locale_path
      I18n.load_path << locale_path
      I18n.backend.send(:init_translations)
    end

  rescue Exception => err
    logger.error err
    flash.now[:notice] = "#{I18n.locale} translation not available"

    I18n.load_path -= [locale_path]
    I18n.locale = session[:locale] = I18n.default_locale
  end

  def permission_denied
    if logged_in?
      flash[:notice] = "Du besitzt nicht die erforderlichen Rechte um diese Seite zu sehen."
      path = home_path
    else
      flash[:notice] = "Du musst dich einloggen um diese Seite zu sehen."
      path = login_path
    end
    redirect_to path
  end
  
end
