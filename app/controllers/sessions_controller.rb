class SessionsController < ApplicationController
  
  def new
    if current_user
      redirect_to home_path
    end 
  end

  def create
    #binding.pry
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "You are Signed in"
      redirect_to home_path
    else 
      flash[:notice] = "Something went wrong"
      render :new
    end 
    # if user is real and the password is good 
    #   session should be created to be set to the id of the person 
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:notice] = "you have logged out"
  end

end 