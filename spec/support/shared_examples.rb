shared_examples "require sign in" do 
  it "redirects to the sign in page" do 
    session[:user_id] = nil
    action
    expect(response).to redirect_to signin_path
  end 

end 

#In the shared example above we are taking out repeating things 
#that we do in out tests in this instance we keep writing the 
# sign in requirement which if not done will redirect to the 
# signin path. so instead of doing that over and over we just put 
# this is a shared example and we pass in the action that we are trying to
# do that requires a signed in user. 
