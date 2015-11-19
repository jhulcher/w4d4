class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by( session_token: session[:session_token] )
  end

  def user_params
    params[:user].permit(:user_name, :password)
  end

  def login_user!
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user
      login_user!
      redirect_to root_url
    else
      render :new
    end
  end

end
