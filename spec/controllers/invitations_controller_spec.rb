require "rails_helper"

describe InvitationsController do 
  describe "GET new" do 
    it "set @invitations to anew invitation" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      get :new
      expect(assigns(:invitation)).to be_instance_of Invitation

    end 
    it_behaves_like "require sign in" do 
      let(:action) {get :new}
    end 
  end 

  describe "POST create" do 
    it_behaves_like "require sign in" do 
      let(:action) {get :new}
    end 

    context "with valid inputs" do 
      it "redirects to the invitation new page" do 
        alice =Fabricate(:user)
        set_current_user(alice)
        
        post :create, invitation:{recipient_name:"tom", recipient_email:"tom@email.com", message:"this is a cool message"}
        expect(response).to redirect_to new_invitation_path
      end 


      it  "creates an invitation" do 
        alice =Fabricate(:user)
        set_current_user(alice)
        
        post :create, invitation: {recipient_name:"tom", recipient_email:"tom@email.com", message:"this is a cool message"}
        expect(Invitation.count).to eq(1)
      end 
      it "sends an email to the recipient" do 
        alice =Fabricate(:user)
        set_current_user(alice)
        post :create, invitation: {recipient_name:"tom", recipient_email:"tom@email.com", message:"this is a cool message"}
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(["tom@email.com"])
      end 
      
      it "sets the flash success message" do 
        alice =Fabricate(:user)
        set_current_user(alice)
        post :create, invitation: {recipient_name:"tom", recipient_email:"tom@email.com", message:"this is a cool message"}
        
        expect(flash[:notice]).to eq("You have sent an invitation")
      end 
    end 
    


    context "not valid inputs ie no email given" do 
      after {ActionMailer::Base.deliveries.clear}
      it "doesnt create an invitation" do 
        alice =Fabricate(:user)
        set_current_user(alice)
        
        
        expect(Invitation.count).to eq(0)
      end 
      it "doesnt send an email to the the recipient" do 
        alice =Fabricate(:user)
        set_current_user(alice)
        
        post :create, invitation: {recipient_name:"tom", recipient_email:"tom@email.com"}
        expect(ActionMailer::Base.deliveries.count).to eq(0)

      end 
      it "shows a flash message with error" do 
         alice =Fabricate(:user)
        set_current_user(alice)
        post :create, invitation: {recipient_name:"tom", recipient_email:"tom@email.com"}
        
        expect(flash[:notice]).to eq("Please fill in the form below with valid information")

      end 
      it "render invitation page" do 
        alice =Fabricate(:user)
        set_current_user(alice)
        
        post :create, invitation: {recipient_name:"tom"}
        expect(response).to render_template :new


      end 
      it "sets the @user instance variable for the form and errors" do 
        alice = Fabricate(:user)
      set_current_user(alice)
      post :create, invitation: {recipient_name:"tom"}
      expect(assigns(:invitation)).to be_instance_of Invitation
      end 
      
    end 
    
    

  end 

end 