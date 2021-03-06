require "rails_helper"

  feature "Admin user adds a video" do 
    scenario "Admin User Adds A Video " do 
      user = Fabricate(:user, admin: true)
      sign_in(user)
      action = Fabricate(:category, category:"Action")
      visit('/admin/videos/new') 
      fill_in "Title", :with => "Conan"      
      select("Action", :from=> "Category")
      fill_in "Description", :with => "This is a Description of a movie that I am going to watch"
      
      attach_file "Large cover",  "spec/support/uploads/monk_large.jpg"
      attach_file "Small cover",  "spec/support/uploads/monk.jpg"
      fill_in "Video URL", with: "http://www.example.com/my_video.mp4"
      
      click_button "Add Video"
      
      
      
      
      visit home_path
      
      expect(page).to have_selector("img[src='/uploads/monk.jpg']")
      
      find("a[data-movie='Conan']").click
      expect(page).to have_selector("a[href='http://www.example.com/my_video.mp4']")
    end 




  end 