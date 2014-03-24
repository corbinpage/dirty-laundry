class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
    if logged_in?
      redirect_to "/scans/new"
    else
      render "splash"
    end
  end

  def sub_layout
    false
  end

  private
  def login_required
    if !logged_in?
      redirect_to log_in_path, :alert => "Login required!"
    end
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    reset_session
  end
  
  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

end