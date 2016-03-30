require 'rails_helper'


feature "user signs in" do 
  scenario "it signs in with valid username and password" do 
    user = Fabricate(:user)
   sign_in(user)
    expect(page).to have_content("You are Signed in")

  end 

end 