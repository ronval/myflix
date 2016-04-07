require "rails_helper"

feature "User invites friend" do 
  scenario "user successfully invites freind and invitation is accepted" do 
    alice = Fabricate(:user)
    sign_in(alice)

    visit new_invitation_path
    fill_in "Friend's Name", with:"John"
    fill_in "Friend's Email", with:"john@email.com"
    fill_in "Message", with:"This is an invitation to this app"
    click_button "Send Invitation"

    sign_out
    open_email "john@email.com"
    current_email.click_link "Accept Invitation"

    fill_in "Password", with:"123"
    fill_in "Full name", with:"John Doe"
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