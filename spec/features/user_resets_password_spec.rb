require "rails_helper"

feature "User resets Password" do 
  scenario "user successfully resets the password" do 
    alice = Fabricate(:user, password:"old_password")
    
    visit signin_path 
    click_link "Forgot Password"
    fill_in "Email Address", with:alice.email
    click_button "Send Email"
    
    open_email(alice.email)
    current_email.click_link("Reset password")
    
    fill_in "New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "Email", with:alice.email
    fill_in "Password", with:"new_password"
    click_button "login"
    expect(page).to have_content("You are Signed in")
  end 

end 