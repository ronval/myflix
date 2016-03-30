require 'rails_helper'

describe UsersController do 
  describe "GET new" do 
    it "sets the @user variable" do 
      user = Fabricate(:user)
      get :new
      expect(assigns(:user)).to be_instance_of(User)
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
    context "not signed in user" do 
      it "redirects to the sign in page when they arent signed in"
      it "set the flash with a notice for the redirect"
    end 

  end

end 


#we should say what doesnt happen in the test?? 

