require 'rails_helper'

describe UsersController do 
  describe "GET new" do 
    it "sets the @user variable" do 
      user = Fabricate(:user)
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end 
  end 


  describe "POST create" do 
      
      context "when user input is valid" do   
          it "creates an instance if validations worked" do 
            post :create, user: {email: "email@gmail.com", full_name:"martin", password:"password"} 
            expect(User.count).to eq(1)
          end 

          it "redirect to the homepath" do 
            post :create, user: {email: "martin@gmail.com", full_name:"martin", password: "password"}

            expect(response).to redirect_to signin_path
          end 
          it "makes the user follow the inviter" do 
            alice = Fabricate(:user)
            invitation = Fabricate(:invitation, inviter:alice, recipient_email: "john@email.com")
            post :create, user:{email:"john@email.com", password:"123", full_name:"John Doe"}, invitation_token:invitation.token
            john = User.where(email:"john@email.com").first
            expect(john.follows?(alice)).to be true
          end 
          
          it "makes the inviter follow the user" do 
            alice = Fabricate(:user)
            invitation = Fabricate(:invitation, inviter:alice, recipient_email: "john@email.com")
            post :create, user:{email:"john@email.com", password:"123", full_name:"John Doe"}, invitation_token:invitation.token
            john = User.where(email:"john@email.com").first
            expect(alice.follows?(john)).to be true
          end 
          it "expires the invitation upon acceptance" do 
             alice = Fabricate(:user)
            invitation = Fabricate(:invitation, inviter:alice, recipient_email: "john@email.com")
            post :create, user:{email:"john@email.com", password:"123", full_name:"John Doe"}, invitation_token:invitation.token
            john = User.where(email:"john@email.com").first
            expect(Invitation.first.token).to be_nil
          end 



      end 
       context "without valid input" do  
            it "didnt create a user" do 
              post :create, user: {email:"martin@gmail.com"}
              expect(User.count).to eq(0)
            end 
            it "renders the new template " do 
              post :create, user: {email:"martin@gmail"}
              expect(response).to render_template(:new)
            end 
            it "sets @user" do 
              
              post :create, user: {email:"martin@gmail.com", full_name:"martin"}
              expect(assigns(:user)).to be_instance_of(User)
            end 
        end 

        context "sends emails" do 
          after {ActionMailer::Base.deliveries.clear}
          
          it "sends an email when a user signs up with valid inputs" do 
            # user = Fabricate(:user, email:"dom@gmail.com")
            post :create, user: {email:"dom@email.com", password:"123", full_name:"dom john"}
            expect(ActionMailer::Base.deliveries).not_to be_empty
          end 
          it "sends it to the user who signed up with valid inputs" do 
            post :create, user: {email:"dom@email.com", password:"123", full_name:"dom john"}
            message = ActionMailer::Base.deliveries.last.to
            expect(message).to eq(["dom@email.com"])
          end 
          it "has the username content inside the email" do 
            post :create, user: {email:"dom@email.com", password:"123", full_name:"dom john"}
            message = ActionMailer::Base.deliveries.last
            expect(message.body).to include("dom john")
          end 

          it "doesnt send an email when user inputs are invalid" do 
            post :create, user:{email:"bob@email.com", full_name:"bob"}
            expect(ActionMailer::Base.deliveries).to be_empty
          end 
        end 




    end 



  describe "GET show" do 
    context "signed in user" do 
      it "sets the @user variable to the user being picked" do 
        user = Fabricate(:user)
        session[:user_id] = user.id
        get :show, id: user.id
        expect(assigns(:user)).to eq(user)
      end 

    end 
    # context "not signed in user" do 
    #   it "redirects to the sign in page when they arent signed in"
    #   it "set the flash with a notice for the redirect"
    # end 

  end


  describe "GET new_with_invitation_token" do 
    it "sets @user with recipient's email" do 
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email) 
    end 

    it "renders the new user template" do 
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new 

    end 

    it "redirects to expired token page when token is expired" do 
      
      get :new_with_invitation_token, token: "arfewfw8934"
      expect(response).to redirect_to expired_token_path
    end 

    it "sets @invitation_token" do 
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token) 
    end 
  end 

end 


#we should say what doesnt happen in the test?? 

