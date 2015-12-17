require 'rails_helper'


describe Category do 
  it{ should have_many(:videos)}  
 
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
