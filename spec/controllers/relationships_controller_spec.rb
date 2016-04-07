require "rails_helper"


describe RelationshipsController do 
  describe "GET index" do 
    it "sets @relationships to the current user's following relationship"do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader:bob)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end 

    it_behaves_like "require sign in" do 
      let(:action) {get :index}
    end 

  end 


  describe "DELETE Destroy" do 
    it_behaves_like "require sign in" do 
      let(:action) {delete :destroy, id:4}
    end 
    it "deletes the relationship if the current user is the follower" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower:alice, leader:bob)
      delete :destroy, id:relationship
      expect(Relationship.count).to eq(0)
    end 
    it "does not delete the relationship if the current use ris not the follower" do 
       alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      jon = Fabricate(:user)
      relationship = Fabricate(:relationship, follower:jon, leader:bob)
      delete :destroy, id:relationship
      expect(Relationship.count).to eq(1)
    end 
    it "redirects to the people page" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower:alice, leader:bob)
      delete :destroy, id:relationship
      expect(response).to redirect_to people_path
    end 

  end 

  describe "POST create" do 
    it_behaves_like "require sign in" do 
      let(:action) {post :create, id:4}
    end 
    
     it "redirects to the people page when they have followed" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, leader_id:bob.id
      expect(response).to redirect_to people_path
    end 



    it "creates a relationship that the current user follows to the leader" do 

      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      post :create, leader_id:bob.id
      expect(alice.following_relationships.first.leader).to eq(bob)
    end 
   
    it "it doesnt create a relationship twice" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower:alice, leader:bob)
      
      post :create, leader_id:bob.id
      expect(Relationship.count).to eq(1)

    end 
    it "doesnt allow you to follow your self" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      
      post :create, leader_id:alice.id
      expect(Relationship.count).to eq(0)

    end 

  end 



end