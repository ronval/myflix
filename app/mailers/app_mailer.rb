class AppMailer < ActionMailer::Base

  def send_welcome_email(user)
    @user = user
    mail from:"ron@email.com", to:user.email, subject:"Welcome to our Myflix App #{user.full_name}"
  end
  def email_password(user)
    @user = user
    mail from:"ron@gmail.com", to:user.email, subject:"Resetting your password"
  end

  def send_invitation_email(invitation)
    @invitation = invitation
    mail from:"ron@gmail.com", to:invitation.recipient_email, subject:"We invite you!"
  end

end 