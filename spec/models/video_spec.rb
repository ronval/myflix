require 'rails_helper'



describe Video do 
  it "should save itself to the database" do 
    vid = Video.new(title:"Rogue One", 
                    description:"Star wars fighter pilots", 
                    small_cover_url:"/tmp/batmanvsuperman.jpg", 
                    large_cover_url:"/tmp/monk_large.jpg", 
                    category_id: 3 )
    vid.save
    expect(Video.last.title).to eql("Rogue One")
  end 

  context "Video should be categorized as Comic Book" do 
    it "should belong to a category" do
    
    the_category = Category.create(category:"Comic Book")


    vid = Video.new(title:"Rogue One", 
                    description:"Star wars fighter pilots", 
                    small_cover_url:"/tmp/batmanvsuperman.jpg", 
                    large_cover_url:"/tmp/monk_large.jpg", 
                    category: the_category )
    vid.save 
    
      expect(Video.last.category.category).to eql("Comic Book") 
    end 

  end 



end 





# test for cat model
#test video can belong to  a category 
#and that a category can have many videos
