
 
class  UsersController < ApplicationController
  
  def new 
    @user = User.new 
    @invitation = Invitation.new(token:"") 
  end

  def create
    @user = User.new(user_params)
    @invitation = Invitation.new(token:"") 
   
   if @user.valid?
      
       

       Stripe.api_key = ENV['STRIPE_API_KEY']

      # Get the credit card details submitted by the form
      token = params[:stripeToken]

      # Create the charge on Stripe's servers - this will charge the user's card
      # begin
      #   charge = StripeWrapper::Charge.create(
      #     :amount => 1000, # amount in cents, again
      #     :currency => "cad",
      #     :source => token,
      #     :description => "Example charge"
      #   )
      # rescue Stripe::CardError => e
      #   flash[:error]= e.message
      #   redirect_to home_path
      # end


        charge = StripeWrapper::Charge.create(
          :amount => 1000, # amount in cents, again
          :currency => "cad",
          :source => token,
          :description => "Example charge"
        )
      if charge.successful?
        flash[:notice] = "Thank you for signing up you payment went through"
        
        #AppMailer.send_welcome_email(@user).deliver
        @user.save
        EmailWorker.perform_async(@user.id)
        if params[:invitation_token]  && params[:invitation_token] != ""
        #invitation = Invitation.where(token:params[:invitation_token]).first
        invitation = Invitation.find_by(token:params[:invitation_token])
        @user.follow(invitation.inviter)
        invitation.inviter.follow(@user)
        invitation.update_column(:token,nil)
        end 




        redirect_to signin_path
      else 
        
        flash[:error]= charge.error_message
        render :new
      end 
      
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