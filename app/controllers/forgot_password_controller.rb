class ForgotPasswordController < ApplicationController
  def new
    
  end

  def create
    
    @user = User.find_by(email:params[:email])
    if @user 
      redirect_to forgot_password_confirmation_path
      AppMailer.email_password(@user).deliver
    else 
      redirect_to forgot_password_path
      flash[:notice] = "You must add a registered email"
    end 
  end

  def confirm
    
  end

end 