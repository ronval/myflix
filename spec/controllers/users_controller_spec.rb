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
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123, user: {email: "email@gmail.com", full_name:"martin", password:"password"} 
            expect(User.count).to eq(1)
          end 

          it "redirect to the homepath" do 
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123, user: {email: "martin@gmail.com", full_name:"martin", password: "password"}

            expect(response).to redirect_to signin_path
          end 
          it "makes the user follow the inviter" do 
            alice = Fabricate(:user)
            invitation = Fabricate(:invitation, inviter:alice, recipient_email: "john@email.com")
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123,user:{email:"john@email.com", password:"123", full_name:"John Doe"}, invitation_token:invitation.token
            john = User.where(email:"john@email.com").first
            expect(john.follows?(alice)).to be true
          end 
          
          it "makes the inviter follow the user" do 
            alice = Fabricate(:user)
            invitation = Fabricate(:invitation, inviter:alice, recipient_email: "john@email.com")
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123 ,user:{email:"john@email.com", password:"123", full_name:"John Doe"}, invitation_token:invitation.token
            john = User.where(email:"john@email.com").first
            expect(alice.follows?(john)).to be true
          end 
          it "expires the invitation upon acceptance" do 
             alice = Fabricate(:user)
            invitation = Fabricate(:invitation, inviter:alice, recipient_email: "john@email.com")
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123, user:{email:"john@email.com", password:"123", full_name:"John Doe"}, invitation_token:invitation.token
            john = User.where(email:"john@email.com").first
            expect(Invitation.first.token).to be_nil
          end 

          it "sets the @invitation variable invitation instance" do 
            alice = Fabricate(:user)
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123, user:{email:"john@email.com", password:"123", full_name:"John Doe"}, invitation_token:''
            expect(assigns(:invitation)).to be_instance_of Invitation
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
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123, user: {email:"dom@email.com", password:"123", full_name:"dom john"}
            expect(ActionMailer::Base.deliveries).not_to be_empty
          end 
          it "sends it to the user who signed up with valid inputs" do 
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123, user: {email:"dom@email.com", password:"123", full_name:"dom john"}
            message = ActionMailer::Base.deliveries.last.to
            expect(message).to eq(["dom@email.com"])
          end 
          it "has the username content inside the email" do 
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, token:123, user: {email:"dom@email.com", password:"123", full_name:"dom john"}
            message = ActionMailer::Base.deliveries.last
            expect(message.body).to include("dom john")
          end 

          it "doesnt send an email when user inputs are invalid" do 
            post :create, user:{email:"bob@email.com", full_name:"bob"}
            expect(ActionMailer::Base.deliveries).to be_empty
          end 
        end 

        context "with a successful charge" do 
          it "sets the flash notice" do 
            #user = Fabricate(:user)
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, stripeToken:123, user:{email:"user123@email.com", password:"password", full_name:"Martin"}
            
            expect(flash[:notice]).to eq("Thank you for signing up you payment went through")
          end 
          it "redirects to signin_path" do 
            charge = double('charge')
            charge.stub(:successful?).and_return(true)
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, stripeToken:123, user:{email:"user123@email.com", password:"password", full_name:"Martin"}
            
            expect(response).to redirect_to signin_path

          end 
        end 


        context "with an error charge" do 
          it "sets the error message" do 
            charge = double('charge')
            charge.stub(:successful?).and_return(false)
            charge.stub(:error_message).and_return("Sorry Something went wrong!!!")
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, stripeToken:123, user:{email:"user123@email.com", password:"password", full_name:"Martin"}
            
            expect(flash[:error]).to eq("Sorry Something went wrong!!!")
          end 
          it "renders new" do 
            charge = double('charge')
            charge.stub(:successful?).and_return(false)
            charge.stub(:error_message).and_return("Sorry Something went wrong!!!")
            StripeWrapper::Charge.stub(:create).and_return(charge)
            post :create, stripeToken:123, user:{email:"user123@email.com", password:"password", full_name:"Martin"}
            
            expect(response).to render_template :new
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

