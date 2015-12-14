require 'spec_helper'



describe Video do 
  it "should save itself to the database" do 
    vid = Video.new(title:"Rogue One", description:"Star wars fighter pilots", small_cover_url:"/tmp/batmanvsuperman.jpg", large_cover_url:"/tmp/monk_large.jpg", category_id: 3 )
    vid.save
    expect(Video.last.title).to eql("Rogue One")
  end 

end 