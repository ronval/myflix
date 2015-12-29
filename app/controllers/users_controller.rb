class  UsersController < ApplicationController
  
  # def new_session
  #   @user = User.new
  # end

  # def create_session
  #   @user = User.find(params[:id])

  #   if @user.exists && @user.authenticate
  #     session[:user_id] = @user.id
  #     flash[:notice] = "You are Signed in"
  #     redirect_to home_path
  #   else 
  #     flash[:notice] = "Something went wrong"
  #     render :new_session
  #   end 
  #   # if user is real and the password is good 
  #   #   session should be created to be set to the id of the person 
  # end

  def new 
    @user = User.new  
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Thank you for signing up "
      redirect_to home_path
    else
      render :new
    end 
  end




  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

  def password_params
    params.require(:user).permit(:email, :password)
  end
end 