class SessionsController < ApplicationController

  def new
  end

  def create
    login_user!
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to root_url
  end
end
