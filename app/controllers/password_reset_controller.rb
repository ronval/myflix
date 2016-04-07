class PasswordResetController <ApplicationController
  def show
    user = User.where(token:params[:id]).first
    
    if user
      @token = user.token
    else  
      redirect_to expired_token_path 
    end 
    

  end
  def expired_token
    
  end

  def create
    user = User.where(token:params[:token]).first
    if user 
      user.password = params[:password]
      user.generate_token
      user.save
      redirect_to signin_path
      flash[:notice] = "you have changed you password"
    else
      redirect_to expired_token_path
    end 
  end

end