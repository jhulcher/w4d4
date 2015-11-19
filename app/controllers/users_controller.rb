class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      login_user!
      
    else
      render :new
    end
  end

end
