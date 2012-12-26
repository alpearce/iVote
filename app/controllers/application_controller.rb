class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
    def require_login
      if self.current_user == nil
        logger.error "Current User Not Logged in"
        logger.error "CURRENT USER: #{@current_user}"
        redirect_to "/"
      end
    end
  
  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end
