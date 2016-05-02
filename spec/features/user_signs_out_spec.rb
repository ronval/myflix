require 'rails_helper'


feature "user signs in", js:true do 
  scenario "it signs in with valid username and password" do 
    user = Fabricate(:user)
    sign_in(user)
    #sleep 2
    
    click_link "sign-out"
    expect(page).to have_content("you have logged out")

    # within(:css, "li#sign-out") do
    #   expect(page).to have_content("Sign out")
    # end

  end 

end