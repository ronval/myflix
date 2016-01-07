class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception




  helper_method :current_user, :logged_in?

  def current_user
   # Here we have to set the current user to the user from the session 
   #it should make sure that it is real and that it is not nil 
   @current_user ||= User.find(session[:user_id]) unless session[:user_id] == nil

  end


  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:notice] = "You must be logged in to do that"
      redirect_to signin_path

    end 
  end
end
