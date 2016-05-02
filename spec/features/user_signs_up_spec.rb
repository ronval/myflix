require "rails_helper"

feature "user signs up" do 
  scenario "with valid credit card", js: true do 
    VCR.use_cassette('feature_new_user_with_valid_card', :allow_unused_http_interactions => false) do
      visit new_user_path
      fill_in "Email", with:"martin5000@email.com"
      fill_in "Password", with:"123"
      fill_in "Full name", with:"John Doe"
      fill_in "credit-card", with:4242424242424242
      
      fill_in "security-code", with:242
      select "3 - March", from:"date_month"
      select "2017", from:"date_year"
      click_button "Sign Up"
      save_and_open_page
      expect(page).to have_content "Thank you for signing up you payment went through"
    end
  end
  
  scenario "with invalid credit card", js: true  do 
      VCR.use_cassette('feature_new_user_with_invalid_card', :allow_unused_http_interactions => false) do
      visit new_user_path
        fill_in "Email", with:"wolf@email.com"
        fill_in "Password", with:"123"
        fill_in "Full name", with:"John Doe"
        fill_in "credit-card", with:4000000000000002
        
        fill_in "security-code", with:242
        select "3 - March", from:"date_month"
        select "2017", from:"date_year"
        click_button "Sign Up"
        save_and_open_page
        expect(page).to have_content "Your card was declined."

    end 
  end 
end 