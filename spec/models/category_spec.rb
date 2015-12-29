require 'rails_helper'


describe Category do 
  it{ should have_many(:videos)}  

  describe "#recent_videos" do 
    it "returns an empty array if there are no movies in the category" do 
      horror = Category.new(category:"Horror")
      
      expect(horror.recent_videos).to eq([])
    end 


    it "it returns an array with 6 or less movies from newest to oldest" do 
      horror = Category.new(category:"Horror")
      movie = Video.create(title:"Jaws", description:"under the sea", 
                           created_at: 1.day.ago, category:horror)
      movie2 = Video.create(title:"Halloween", description:"killer",
                            created_at: 2.day.ago, category:horror)
      movie3 = Video.create(title:"chucky", description:"ugly doll", 
                            created_at: 3.day.ago, category:horror)
      movie4 = Video.create(title:"HIIIII", description:"under the sea", 
                           created_at: 1.day.ago, category:horror)
      movie5 = Video.create(title:"Halloween", description:"killer",
                            created_at: 2.day.ago, category:horror)
      movie6 = Video.create(title:"chucky", description:"ugly doll", 
                            created_at: 3.day.ago, category:horror)
      movie7 = Video.create(title:"HOOOOOO", description:"under the sea", 
                           created_at: 1.day.ago, category:horror)
      
      expect(horror.recent_videos.count).to eq(6)
    end 
  end 
 
end 


 # it "saves itself" do 
  #   category = Category.new(category:"Romance")
  #   category.save
  #   expect(Category.last.category).to eql("Romance")
  # end

  # it "can have many videos" do 
      
  #     cat = Category.create(category:"western")
  #     cat.save

  #     vid = Video.create(title:"Batman v Superman", 
  #                       description:"Mighty Heros fighting", 
  #                       small_cover_url:"/tmp/batmanvsuperman.jpg", 
  #                       large_cover_url:"/tmp/monk_large.jpg", 
  #                       category: cat)

  #     vid2 = Video.create(title:"wonderwoman", 
  #                       description:"Mighty Hero", 
  #                       small_cover_url:"/tmp/monk.jpg", 
  #                       large_cover_url:"/tmp/monk_large.jpg", 
  #                       category:cat)

  #     vid.save
  #     vid2.save
  #     binding.pry

  #     expect(Category.first.videos.size).to eql(2)



      

  #   end  
