module SessionsHelper

  def current_user=(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def login_user!
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user.nil?
      render :json => "Credentials were wrong"
    else
      user.reset_session_token!
      self.current_user = user
      redirect_to cats_url
    end
  end

end
