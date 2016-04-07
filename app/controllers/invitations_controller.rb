class InvitationsController < ApplicationController 
  before_action :require_user
  def new
    @invitation = Invitation.new
  end


  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.inviter_id = current_user.id

    if @invitation.valid?
      @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:notice] = "You have sent an invitation"
      redirect_to new_invitation_path
    else
      @invitation = Invitation.new
      render :new
      flash[:notice] = "Please fill in the form below with valid information"
    end  


  end


  private 

  def invitation_params

    params.require(:invitation).permit(:inviter_id, :recipient_name, :recipient_email, :message)
    
  end

end 