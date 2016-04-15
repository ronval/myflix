require "rails_helper"

describe Admin::VideosController do 
  describe "GET new" do 
    it_behaves_like "require sign in" do 
      let(:action){get :new}
    end 
    it "sets teh @video instace variable to a new video" do 
      user = Fabricate(:user, admin:true)
      session[:user_id] = user.id
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end 
    it "redirects regular users to the home path" do 
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end 
    it "set a flash error for regular users" do 
      set_current_user
      get :new
      expect(flash[:notice]).not_to be_blank 
    end 
  end 

  describe "POST create" do 
    it_behaves_like "require sign in" do 
      let(:action) {post :create}
    end 
    it "redirects for non admin users" do 
      user = Fabricate(:user)
      session[:user_id] = user.id
      category = Fabricate(:category)
      post :create, video:{title:"Ninja turtles", description:"This is a grea movie", category_id:category.id}
      expect(response).to redirect_to home_path
    end 
    
    context "valid inputs" do 
      it "redirects to the create video path" do 
        user = Fabricate(:user, admin:true)
        session[:user_id] = user.id
        category = Fabricate(:category)
        post :create, video:{title:"Ninja turtles", description:"This is a grea movie", category_id:category.id}
        expect(response).to redirect_to new_admin_video_path
      end 
      it "it creates a video" do 
        user = Fabricate(:user, admin:true)
        session[:user_id] = user.id
        category = Fabricate(:category)
        post :create, video:{title:"Ninja turtles", description:"This is a grea movie", category_id:category.id}
        expect(Video.count).to eq(1)
      end 
      it "it sets the flash notice to success" do 
          user = Fabricate(:user, admin:true)
        session[:user_id] = user.id
        category = Fabricate(:category, category:"action")
        post :create, video:{title:"Ninja turtles", description:"This is a grea movie", category_id:category.id}
        expect(flash[:notice]).not_to be_blank
      end 

    end 
    context "invalid inputs"do 
      it "doesnt create a video" do 
        user = Fabricate(:user, admin:true)
        session[:user_id] = user.id
        category = Fabricate(:category)
        post :create, video:{description:"This is a grea movie", category_id:category.id}
        expect(Video.count).to eq(0)
      end 
      it "renders the new page" do 
         user = Fabricate(:user, admin:true)
        session[:user_id] = user.id
        category = Fabricate(:category)
        post :create, video:{description:"This is a grea movie", category_id:category.id}
        expect(response).to render_template :new
      end 
      it "sets the @video instance variable" do 
         user = Fabricate(:user, admin:true)
        session[:user_id] = user.id
        category = Fabricate(:category)
        post :create, video:{description:"This is a grea movie", category_id:category.id}
        expect(assigns(:video)).to be_instance_of Video

      end 
      it "sets the flash notice for an error" do 
          user = Fabricate(:user, admin:true)
        session[:user_id] = user.id
        category = Fabricate(:category, category:"action")
        post :create, video:{description:"This is a grea movie", category_id:category.id}
        expect(flash[:notice]).to eq("You missed some information") 
      end 
    end 
    
  end 



end 