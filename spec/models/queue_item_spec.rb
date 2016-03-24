require "rails_helper"

describe QueueItem do 
   it {should belong_to(:user)}
   it {should belong_to(:video)}
   it {should validate_numericality_of(:position).only_integer}
   
   describe "#video_title" do 
    it "returns the title of the assocaited video" do 
      video= Fabricate(:video, title:"Monk")
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Monk')
    end 
   end

  describe "#score" do 
    it "returns the rating from the review when the review is present" do 
      video = Fabricate(:video)
      user  = Fabricate(:user)
      review  = Fabricate(:review, user:user, video: video, score: 2)
      queue_item = Fabricate(:queue_item, user:user, video:video)
      expect(queue_item.score).to eq(2)
    end 
    it "returns nil when the review is not present" do 
      video = Fabricate(:video)
      user  = Fabricate(:user)
      
      queue_item = Fabricate(:queue_item, user:user, video:video)
      expect(queue_item.score).to eq(nil)
    end 
  end  

  describe "score= " do 
    it "changes the rating of the review if the review is present" do 
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user:user, video:video, score:2)
      queue_item = Fabricate(:queue_item, user:user, video:video)
      queue_item.score =  4
      expect(Review.first.score).to eq(4)

    end 
    it "clears the rating of the review if the review is present" do 
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user:user, video:video, score:2)
      queue_item = Fabricate(:queue_item, user:user, video:video)
      queue_item.score = nil
      expect(Review.first.score).to be_nil
    end 
    it "creates a review with the rating if the review is not presene" do 
      video = Fabricate(:video)
      user = Fabricate(:user)
      
      queue_item = Fabricate(:queue_item, user:user, video:video)
      queue_item.score = 3
      expect(Review.first.score).to eq(3)

    end 

  end 

  describe "#category_name" do 
    it "returns the category's name of the video " do 
      category = Fabricate(:category, category:"comedy")
      video = Fabricate(:video, category:category)
      queue_item = Fabricate(:queue_item, video:video)
      expect(queue_item.category_name).to eq("comedy")

    end 
  end 

  describe "#category" do 
    it "returns the category of the video" do 
      category = Fabricate(:category, category:"comedy")
      video = Fabricate(:video, category:category)
      queue_item = Fabricate(:queue_item, video:video)
      expect(queue_item.category).to eq(category)
    end 
  end 

  
  
end 