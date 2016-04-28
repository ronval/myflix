require "rails_helper"

feature "User invites friend", {js:true ,vcr:true} do 
     
  scenario "user successfully invites freind and invitation is accepted", :driver => :selenium do 
      
      alice = Fabricate(:user)
      sign_in(alice)
      expect(page).to have_content("You are Signed in")
      visit new_invitation_path
      find_field("Friend's Name")
      fill_in "Friend's Name", with:"John"
      
      fill_in "Friend's Email", with:"john@email.com"
      fill_in "Message", with:"This is an invitation to this app"
      click_button "Send Invitation"
      save_and_open_page
      sign_out
      open_email "john@email.com"
      current_email.click_link "Accept Invitation"

      fill_in "Password", with:"123"
      fill_in "Full name", with:"John Doe"
      fill_in "credit-card", with:4242424242424242
        
        fill_in "security-code", with:242
        select "3 - March", from:"date_month"
        select "2017", from:"date_year"
        
      click_button "Sign Up"

      fill_in "Email", with:"john@email.com"
      fill_in "Password", with:"123"
      click_button "login"

      click_link "People"
      expect(page).to have_content alice.full_name

      sign_in(alice)
      click_link "People"
      expect(page).to have_content "John Doe"

      clear_email
     
  end 

end