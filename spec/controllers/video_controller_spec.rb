require 'rails_helper'


describe VideosController do 
    describe "GET show" do 
      it "sets the the @videos variable to the picked video instance " do 
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
      
    
    end 

end 