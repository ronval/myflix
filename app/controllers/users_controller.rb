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
    @invitation = Invitation.new(token:"") 
  end

  def create
    @user = User.new(user_params)
    
    
    if @user.save
      if params[:invitation_token]  && params[:invitation_token] != ""
        #invitation = Invitation.where(token:params[:invitation_token]).first
        invitation = Invitation.find_by(token:params[:invitation_token])
        @user.follow(invitation.inviter)
        invitation.inviter.follow(@user)
        invitation.update_column(:token,nil)
      end 
      flash[:notice] = "Thank you for signing up "
      AppMailer.send_welcome_email(@user).deliver
      redirect_to signin_path
    else
      render :new
    end 
  end

  def show
    @user = User.find_by(id:params[:id])
  end


  def new_with_invitation_token
    @invitation = Invitation.find_by(token:params[:token])
    
    if @invitation
      @user = User.new(email:@invitation.recipient_email)
      @invitation_token = @invitation.token
      render :new
    else
      redirect_to expired_token_path
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