def set_current_user(user=nil)
  session[:user_id]= (user || Fabricate(:user)).id
  
end

def sign_in(a_user=nil)
   user =a_user || Fabricate(:user)
   visit signin_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "login"
end

def click_on_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click
end


def sign_out
  click_link "Sign out"
end