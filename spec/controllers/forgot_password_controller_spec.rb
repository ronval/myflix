require "rails_helper"

describe ForgotPasswordController do 
  describe "POST create" do 
    context "with blank input" do 
      it "redirects to the forgot password page" do 
        post :create, email:""
        expect(response).to redirect_to forgot_password_path

      end 

      it "shows an error message" do 
        post :create, email:""
        expect(flash[:notice]).not_to be_blank
      end 
    end 
    context "with existing email" do 
      it "redirects to the forgot password confirmation page" do 
        user = Fabricate(:user, email:"ron@email.com")
        post :create, email:user.email
        expect(response).to redirect_to forgot_password_confirmation_path

      end 
      it "sends an email to the email address" do 
        user =  Fabricate(:user, email:"ron@email.com")
        post :create, email:user.email
        expect(ActionMailer::Base.deliveries.last.to).to eq(["ron@email.com"])
      end  
    end 
    context "with non existing email" do 
      it "tells the user a notice that the email is invalid" do 
        post :create, email:"Bobby@gmail.com"
        expect(flash[:notice]).not_to be_blank
      end
      it "redirects to forgot password" do 
        post :create, email:"Bobby@gmail.com"
        expect(response).to redirect_to forgot_password_path
      end 
    end 
  end 
end 