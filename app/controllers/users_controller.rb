class  UsersController < ApplicationController
  
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
      EmailWorker.perform_async(@user.id)
      #AppMailer.send_welcome_email(@user).deliver
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