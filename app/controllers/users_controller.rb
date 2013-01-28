class UsersController < ApplicationController
  before_filter :require_login
  def index
    @users = User.all
    @proxies = Proxy.all
  end
  
  def assign_proxy
    @proxy = @current_user.proxy_id
    @proxy = User.find_by_id(@proxy)
    @users = User.where(:proxy_id == nil)
  end
  
  def admin
    current_user.admin = true
    current_user.save
    redirect_to "/users"
  end
  
  def show
    redirect_to "/users"
  end
  
  def destroy
    @candidate = User.find(params[:id])
    @candidate.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def proxy_assign
    logger.info "#{params}"
    
  end
  
end
