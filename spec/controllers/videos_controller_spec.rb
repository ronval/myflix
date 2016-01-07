require 'rails_helper'


describe VideosController do 
   
  describe "GET show" do 
    context "with authenticated users" do 
      before do 
        session[:user_id] = Fabricate(:user).id
      end 
      it "sets the the @videos variable to the picked video instance " do 
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:videos)).to eq(video)
      end
      it "renders show template" do 
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to render_template(:show) 
      end 

      it "sets the @review variable" do 
        session[:user_id] = Fabricate(:user).id
        video = Fabricate(:video)
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)
        get :show, id: video.id
        
        

        expect(assigns(:reviews)).to match_array([review1, review2])

      end 
    end 
    context "with no authenticated user " do 
     it "renders show template" do 
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to signin_path
      end 
    end   
    
      
  end 


  describe "POST search" do 
    context "with authenticated user" do 
      before do 
        session[:user_id] = Fabricate(:user).id
      end 
      it "assigns @video variable with the results array" do 
        video = Fabricate(:video, title:"superman")
        post :search, search_term: "superman"
        expect(assigns(:videos)).to eq([video])
      end 
      it "renders search template" do 
        video = Fabricate(:video)
        get :search
        expect(response).to render_template(:search) 
      end 
    end  

    it "redirects if there are no authenticated users" do 
      superman = Fabricate(:video, title: "superman")
      post :search, search_term: "super"
      expect(response).to redirect_to signin_path
    end 
  end  


end 