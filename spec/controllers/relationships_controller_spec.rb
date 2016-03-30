require "rails_helper"


describe RelationshipsController do 
  describe "GET index" do 
    it "sets @relationships to the current user's following relationship"do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader:bob)
      get :index
      expect(assigns(:relationship)).to eq([relationship])
    end 

    it_behaves_like "require sign in" do 
      let(:action) {get :index}
    end 

  end 




end