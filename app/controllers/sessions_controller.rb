class SessionsController < ApplicationController
  #before_action :require_logged_out

  def new
    render :new
  end

  def create
    #debugger
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    
    if @user
      login(@user)
      redirect_to cats_url
    else
      render :new
      flash.now[:errors] = ['??? where the password ???']
    end
  end

  def destroy
    user = current_user
    user.reset_session_token! unless user.nil?
    session[:session_token] = nil
  end
end
