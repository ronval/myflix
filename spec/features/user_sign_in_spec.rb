require 'rails_helper'


feature "user signs in", js:true do 
  scenario "it signs in with valid username and password", :driver => :selenium do 
    user = Fabricate(:user)
    sign_in(user)
    sleep 2
    expect(page).to have_content("You are Signed in")

  end 

end 