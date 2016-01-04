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
          expect(assigns(:video)).to eq(videos)
        end
      end 
    end 

end 