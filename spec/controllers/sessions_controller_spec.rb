require 'rails_helper'

describe SessionsController do 
  describe "GET new" do 
    it "render the new template for users to sign in" do 
      get :new
      expect(response).to render_template(:new)
    end 

    it "redirects to home_path when logged in" do 
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end 
  end 



  describe "POST create" do 
    context "when username is correct and password is correct" do 
      
      

      it " created a session for the user " do 
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(session[:user_id]).to eq(alice.id)
      end 

      it "it redirects to home_path" do 
        alice = Fabricate(:user)
        post :create, email: alice.email, password: alice.password
        expect(response).to redirect_to home_path
      end 

      it "shows the flash message" do 
        alice = Fabricate(:user)
        post :create, email:alice.email, password: alice.password
        expect(flash[:notice]).not_to be_empty
      end 
    end
    
    context "when either the username or password is incorrect" do 

      it "doesnt create a session for the user" do 
        alice = Fabricate(:user)
        post :create, email:alice.email, password:alice.password + "hihih"
        expect(session[:user_id]).not_to eq(alice.id)
      end 
      
      it "renders the new template" do 
        alice = Fabricate(:user)
        post :create, email: alice.email
        expect(response).to render_template :new
      end 
      it "shows the flash message" do 
        alice = Fabricate(:user)
        post :create, email: alice.email
        expect(flash[:notice]).not_to be_empty 
      end 
    end 
  end 

  describe "GET destroy" do 
    it "sets the user session to nil" do 
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end 
    it "redirects to the rootpath" do 
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(response).to redirect_to root_path
    end
    it "sets the flash notice" do 
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(flash[:notice]).not_to be_blank
    end 
  end 





end 