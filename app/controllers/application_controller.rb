# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :mailer_set_url_options
  layout 'application'
  
  helper_method :current_user_session, :current_user, :logged_in?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied." # exception.message
    redirect_to root_url
  end
  

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  # figure out where the root url should go depending on user status
  def home_check
    if logged_in? && @current_user.admin?
      puts @current_user
      redirect_to account_url(@current_user.id)
      return
    elsif logged_in?
      redirect_to cases_path
    else
      redirect_to page_path("home")
      return
    end
  end

protected
  # User management helpers and methods
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def require_user
    unless current_user
      store_location
      flash[:error] = "You must be logged in to access this page."
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:error] = "You must be logged out to access this page."
      redirect_to account_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def logged_in?
    current_user ? true : false
  end

  
end
