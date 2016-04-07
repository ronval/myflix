require "rails_helper"


describe PasswordResetController do 
  describe "GET show" do 
    it "renders the reset password template if the tolen is valid" do 
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :show, id:"12345"
      expect(response).to render_template :show
    end 
    it "redirects to the expired token page if the toekn is not valid" do 
      get :show, id:"12345"
      expect(response).to redirect_to expired_token_path

    end 
    it 'sets @token ' do
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :show, id:"12345"
      expect(assigns(:token)).to eq("12345")
    end 

  end 

  describe "POST create" do 
    context "with valid token" do 
      it "redirects to the sign in page" do 
        alice = Fabricate(:user, password:"old_password")
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(response).to redirect_to signin_path
      end 
      it "updates the user's password" do 
        alice = Fabricate(:user, password:"old_password")
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(alice.reload.authenticate("new_password")).to eq(alice)
      end 

      it "sets the flash message" do 
        alice = Fabricate(:user, password:"old_password")
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(flash[:notice]).to eq("you have changed you password")
      end 
      it "regenerates the user token" do 
        alice = Fabricate(:user, password:"old_password")
        alice.update_column(:token, "12345")
        post :create, token: "12345", password: "new_password"
        expect(alice.reload.token).not_to eq("12345") 
      end 
    end 
    context "with invalid token" do 
      it "redirects to the expired token path" do 
        post :create, token: "12345", password:"some password"
        expect(response).to redirect_to expired_token_path
      end
    end 

  end 

end 