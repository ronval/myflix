require 'rails_helper'

describe ReviewsController do
  describe "POST create" do 
    context "With Authenticated users" do 
      
      let(:current_user) {Fabricate(:user)}
      before {session[:user_id] = current_user.id}
      
      context "with valid inputs" do 
        it "redirects to the show page " do 
           video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to video        
        end 
        
        it "creates a review" do 
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq(1)
        end 
        
        it "creates a review associated with the video"  do 
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.video).to eq(video)
        end 

        it "craetes a review associated with the signed in user" do 
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id

          expect(Review.first.user).to eq(current_user)
        end 
      end 

      context "without valid inputs"
        it "doesnt created a review " do 
          video = Fabricate(:video)
          post :create, review: {score:1}, video_id: video.id
          expect(Review.count).to eq(0)
        end 
        it "renders video show template" do 
          video =  Fabricate(:video)
          post :create, review: {score:1}, video_id: video.id
          expect(response).to render_template "videos/show"
        end 

        it "sets @video" do 
          video = Fabricate(:video)
          post :create, review: {score:1}, video_id: video.id
          expect(assigns(:video)).to eq(video)
        end 
        it "sets @review" do 
          video = Fabricate(:video)
          review = Fabricate(:review, video: video)
          post :create, review:{score:1}, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end 
    end 
    context "with unauthenticated users" do 
      it "redirects to signin_path" do 
        video = Fabricate(:video)
        post :create, review:Fabricate.attributes_for(:review), video_id:video.id
        expect(response).to redirect_to signin_path
      end

    end 
  end 

end 