class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:username])
    if @user
      login_user!
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    current_user.reset_session_token! if current_user
    render :new
  end

end
