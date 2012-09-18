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
  
end
