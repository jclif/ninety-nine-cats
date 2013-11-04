class SessionsController < ApplicationController
  skip_before_filter :require_login

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
