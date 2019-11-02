class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def login(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logout(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

end