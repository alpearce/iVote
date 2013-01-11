class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
    def require_login
      if self.current_user == nil
        redirect_to root_url
      end
    end
  
  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end
