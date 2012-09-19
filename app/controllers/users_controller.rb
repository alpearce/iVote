class UsersController < ApplicationController
  def index
    @users = User.all
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
  
end
