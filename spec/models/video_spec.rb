require 'rails_helper'



describe Video do 
  it { should belong_to(:category) }
  it {should validate_presence_of(:title)}  
  it {should validate_presence_of(:description)}

  
  describe (".search_by_title") do
    
    it "returns an empty array if there is no result from the query" do
      vid = Video.create(title:"Superman", description:"cool movie")
      expect(Video.search_by_title("batman")).to be_empty

    end

    it "returns an array of one video if there is an excact match" do
      vid = Video.create(title:"Superman", description:"cool movie")
      expect(Video.search_by_title("Superman")).to eq([vid])
    end 
    
    it "returns an array of one video for a partial match" do 
      vid = Video.create(title:"Superman", description:"cool movie")
      expect(Video.search_by_title("Super")).to eq([vid])
    end 
    
  end 
    

  
end 
  # it "should save itself to the database" do 
  #   vid = Video.new(title:"Rogue One", 
  #                   description:"Star wars fighter pilots", 
  #                   small_cover_url:"/tmp/batmanvsuperman.jpg", 
  #                   large_cover_url:"/tmp/monk_large.jpg", 
  #                   category_id: 3 )
  #   vid.save
  #   expect(Video.last.title).to eql("Rogue One")
  # end 

  # context "Video should be categorized as Comic Book" do 
  #   it "should belong to a category" do
    
  #   the_category = Category.create(category:"Comic Book")


  #   vid = Video.new(title:"Rogue One", 
  #                   description:"Star wars fighter pilots", 
  #                   small_cover_url:"/tmp/batmanvsuperman.jpg", 
  #                   large_cover_url:"/tmp/monk_large.jpg", 
  #                   category: the_category )
  #   vid.save 
    
  #     expect(Video.last.category.category).to eql("Comic Book") 
  #   end 

  # end 

  # it "should return false if the title is not blank" do
  #  the_category = Category.create(category:"Comic Book") 
  #   vid = Video.new(title:"Rogue One", 
  #                   description:"Star wars fighter pilots", 
  #                   small_cover_url:"/tmp/batmanvsuperman.jpg", 
  #                   large_cover_url:"/tmp/monk_large.jpg", 
  #                   category: the_category )
  #   vid.save 

  #   expect(vid.title.blank?).to eql(false)
  # end 


  #  it "should not save if description is blank" do
  #  the_category = Category.create(category:"Comic Book") 
  #   vid = Video.new(title:"Rogue One", 
  #                   small_cover_url:"/tmp/batmanvsuperman.jpg", 
  #                   large_cover_url:"/tmp/monk_large.jpg", 
  #                   category: the_category )
  #   vid.save 

  #   expect(Video.count).to eql(0)
  #end 








# test for cat model
#test video can belong to  a category 
#and that a category can have many videos
