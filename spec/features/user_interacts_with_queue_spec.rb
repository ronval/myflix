require 'rails_helper'

feature "user interacts with the queue" do 
  scenario " user adds and reorders videos in the queue" do 
    
    comedies= Fabricate(:category)
    monk = Fabricate(:video, title:"Monk", category:comedies)
    south_park = Fabricate(:video, title:"South Park", category: comedies)
    futurama = Fabricate(:video, title:"Futurama", category: comedies)
    sign_in
    find("a[href='/videos/#{monk.id}']").click
    expect(page).to have_content "#{monk.title}"

    click_link "+ My Queue"
    expect(page).to have_content(monk.title)

    visit video_path(monk)
    expect(page).not_to have_content "+ My Queue"

    visit home_path 
    find("a[href='/videos/#{south_park.id}']").click
    click_link "+ My Queue"
    visit home_path 
    find("a[href='/videos/#{futurama.id}']").click
    click_link "+ My Queue"

    fill_in "video_#{monk.id}", with:'3'
    fill_in "video_#{south_park.id}", with:'1'
    fill_in "video_#{futurama.id}", with:'2'
    expect(find("#video_#{south_park.id}").value).to eq("1")
    expect(find("#video_#{futurama.id}").value).to eq("2")
    expect(find("#video_#{monk.id}").value).to eq("3")

    #to have the test above work we have added in the view an id to the text feild
    #id: "video_#{queue_item.video.id}"
    #this is the easiest solution to filling in a feild that has nothing that is 
    #unique among the field. But if the front end team wants to use the id for other 
    #reasons then we can add the "data" attribute and that takes care of not using 
    #the ID data: {video_id: queue_item.video.id} Then when we look at the 
    #field tag we wull see an attribute data-video-id:"with the number of the video"
    #so now we can use this attribute to find the feild in the test. SInce fill in only works
    #id and name we have to use 
    # find("input[data-video-id='#{monk.id}']").set(3) so we have to use this method to find the 
    #field instead of using fill_in. WE have to also change the test to 
    #expect(find("input[data-video-id='#{monk.id}']")).to eq("3")
  end 

end 



