require "rails_helper"

describe User do 
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:full_name)}
  it {should validate_uniqueness_of(:email)}
  it {should have_many(:queue_items).order(:position)}
  it {should have_many(:reviews).order("created_at DESC")}
  
  it "generates a randon token when the user is created" do 
    user = Fabricate(:user)
    expect(user.token).to be_present
  end 

  describe "#queued_video?" do 
    
    it "returns true when the user queued the video " do 
      user = Fabricate(:user)
      video = Fabricate(:video)
      Fabricate(:queue_item, user:user, video:video)
      expect(user.queued_video?(video)).to be true
    end 
    
    it "return false when the user hasnt queued the video " do 
    user = Fabricate(:user)
    video = Fabricate(:video)
    expect(user.queued_video?(video)).to be false
    end 
  end 

 describe "#follows?" do 
    it " returns true is the user has a following relationship with another user" do 
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader:bob, follower:alice)
      expect(alice.follows?(bob)).to be true
    end 

    it "returns false if the user doesnt have a following relationship woth another user" do 
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      Fabricate(:relationship, leader:alice, follower:bob)
      expect(alice.follows?(bob)).to be false
    end 
  end 

  describe "#follow" do 
    it "follows another user" do 
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      alice.follow(bob)
      expect(alice.follows?(bob)).to be true
    end 

    it "doesnt follow itself" do 
      alice = Fabricate(:user)
      
      alice.follow(alice)
      expect(alice.follows?(alice)).to be false

    end 

  end 

end 